install.packages("tidyverse")
install.packages("factoextra")
install.packages("GGally")
install.packages("mclustcomp")
library(tidyverse)
library(cluster)
library(factoextra)
library(GGally)
library(mclustcomp)

set.seed(123)
theme_set(theme_minimal())


# Data Loading and Codebook

wine_raw <- read_csv("wine_dataset.csv", show_col_types = FALSE)

has_target <- "target" %in% names(wine_raw)

wine <- wine_raw %>%
  rename(
    Alcohol = alcohol,
    Malic_Acid = malic_acid,
    Ash = ash,
    Alkalinity_of_Ash = alcalinity_of_ash,
    Magnesium = magnesium,
    Total_Phenols = total_phenols,
    Flavanoids = flavanoids,
    Nonflavanoid_Phenols = nonflavanoid_phenols,
    Proanthocyanins = proanthocyanins,
    Color_Intensity = color_intensity,
    Hue = hue,
    OD280_OD315 = `od280/od315_of_diluted_wines`,
    Proline = proline
  ) %>%
  {
    if (has_target) rename(., Target = target) else .
  }

feature_cols <- setdiff(names(wine), "Target")


glimpse(wine)
summary(select(wine, all_of(feature_cols)))


base_codebook <- tribble(
  ~Variable, ~Description,
  "Alcohol", "Alcohol content (% by volume)",
  "Malic_Acid", "Malic acid concentration (g/L)",
  "Ash", "Ash content (g/100 mL)",
  "Alkalinity_of_Ash", "Alkalinity of ash (mEq/L)",
  "Magnesium", "Magnesium content (mg/L)",
  "Total_Phenols", "Total phenolic compounds (g/L)",
  "Flavanoids", "Flavonoid content (g/L)",
  "Nonflavanoid_Phenols", "Non-flavonoid phenols (g/L)",
  "Proanthocyanins", "Proanthocyanins (g/L)",
  "Color_Intensity", "Color intensity (absorbance units)",
  "Hue", "Hue of the wine color (ratio)",
  "OD280_OD315", "Optical density ratio at 280/315 nm",
  "Proline", "Proline concentration (mg/L)"
)

codebook <- if (has_target) {
  bind_rows(base_codebook, tibble(Variable = "Target", Description = "Anonymous numeric grouping code (0, 1, 2)"))
} else {
  base_codebook
}

# Exploratory Data Analysis

wine_long <- wine %>%
  pivot_longer(cols = all_of(feature_cols), names_to = "Variable", values_to = "Value")

ggplot(wine_long, aes(x = Value)) +
  geom_histogram(bins = 25, fill = "#8C2D2D", color = "white") +
  facet_wrap(~Variable, scales = "free") +
  labs(title = "Distribution of Wine Chemistry Features", x = "Value", y = "Count")
GGally::ggcorr(wine %>% select(all_of(feature_cols)), label = TRUE, label_round = 2, hjust = 0.75) +
  labs(title = "Correlation Matrix of Chemical Attributes")


# Dimensionality Reduction with PCA 

wine_scaled <- scale(select(wine, all_of(feature_cols)))
pca <- prcomp(wine_scaled, center = TRUE, scale. = TRUE)


fviz_eig(pca) + labs(title = "Variance Explained by Principal Components")


fviz_pca_biplot(pca,
                col.ind = "red",
                col.var = "blue",
                repel = TRUE,
                labelsize = 3
) +
  labs(title = "PCA Biplot (unsupervised)")


# Clustering

km <- kmeans(wine_scaled, centers = 3, nstart = 25)

fviz_cluster(km,
             data = wine_scaled,
             geom = "point",
             ellipse.type = "norm",
             ggtheme = theme_minimal(),
             main = "K-Means Clustering of Wines (k = 3)"
)

sil_width <- silhouette(km$cluster, dist(wine_scaled))
mean_sil <- mean(sil_width[, 3])
mean_sil

fviz_nbclust(wine_scaled, kmeans, method = "gap_stat", nstart = 25, nboot = 50) +
  labs(title = "Gap Statistic Suggests k = 3 Clusters")


hc <- hclust(dist(wine_scaled), method = "ward.D2")
plot(hc, labels = FALSE, hang = -1, main = "Hierarchical Clustering Dendrogram")
rect.hclust(hc, k = 3, border = "#8C2D2D")

hc_clusters <- cutree(hc, k = 3)
km_vs_hc <- table(kmeans = km$cluster, hclust = hc_clusters)
km_vs_hc

if ("Target" %in% names(wine)) {
  ari <- mclust::adjustedRandIndex(as.numeric(wine$Target) + 1, km$cluster)
  ari
} else {
  "No target column present; ARI not computed."
}


