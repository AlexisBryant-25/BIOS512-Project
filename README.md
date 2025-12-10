# BIOS 512 Final Project: Unsupervised Exploration of Wine Chemistry

<img width="236" height="214" alt="image" src="https://github.com/user-attachments/assets/c2c11086-3c77-47bc-b7f4-a80b690f0d5a" />

## Overview
This project analyzes a Kaggle dataset containing 178 laboratory measurements of wines from the same Italian region.
Each record includes 13 chemical attributes and no cultivar label; some dataset copies carry an unlabeled numeric `target` code (0–2), but it is optional for the workflow.
Because cultivar identities are unknown (and the `target` column may be absent), the analysis emphasizes unsupervised structure—EDA, **PCA**, **k-means**, **hierarchical clustering**, and internal validation (silhouette width and the gap statistic)—with an optional post-hoc adjusted Rand index (ARI) check when the anonymous codes are present.


## Dataset Source
**Wine Dataset – Kaggle.**
Laboratory analyses of wines from three cultivars in the same Italian region, featuring chemical measurements such as alcohol, phenolic compounds, acidity metrics, and color intensity.
