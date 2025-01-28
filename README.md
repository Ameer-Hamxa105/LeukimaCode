________________________________________
**Leukemia Classification Using Deep Learning and Grey Wolf Optimization**


This repository implements a novel approach for leukemia classification and hematologic malignancy detection. The system uses advanced image preprocessing, customized neural network models, and hyperparameter tuning to achieve state-of-the-art results. The code is developed in MATLAB and demonstrates an end-to-end pipeline for leukemia image classification.

📘 **Project Overview**

Leukemia is a life-threatening cancer characterized by the abnormal growth of white blood cells. This project proposes a robust automatic framework for accurate leukemia detection using image processing and deep learning techniques. Key components of the solution include:
•	Customized CNN Model (PIDSAN4): A novel neural network architecture for efficient image classification.
•	Vision Transformer (ViT): Lightweight Tiny16 model for enhanced feature learning.
•	Hyperparameter Tuning: Optimized using Grey Wolf Optimization (GWO) to improve model accuracy and performance.
•	Contrast Enhancement: Image preprocessing with hyperbolic sine and dehazing functions.
________________________________________

🧑💻** Implementation Steps**

Step 1: Clone the Repository
git clone https://github.com/Ameer-Hamxa105/LeukimaCode.git
cd LeukimaCode
Step 2: Setup Requirements
•	Install MATLAB R2023b
•	Enable the Image Processing Toolbox
•	Computer Vision Toolbox
•	Vision Transformer Toolbox
Step 3: Prepare Dataset
The dataset should follow this structure:
data/
├── normal/  
│   └── [microscopic images]  
└── leukemia/  
    └── [microscopic images]  
Download the dataset from this link: 
 https://ktuedu-my.sharepoint.com/:f:/g/personal/ameham_ktu_lt/Egnojw-oIcxPufo4JTNtcWQBaA5SGHGt6Vx3nid5xBfHXQ?e=IOArbc
 
**Step 4: Run the Code**

1.	Open MATLAB and navigate to the project directory.
2.	Execute the main script: 
3.	Preprocess the images using the proposed method open: \Modeling\Preprocessing\MainEn.m
4.	Execute the SimpleModel.m file for training the customized PIDSAN4 model and save.
5.	Execute the bertvit.m file for training the ViT model and save.
6.	Open the resting Folder and Execute for the results
   
**Step 5: Hyperparameter Tuning**

The GWO-based tuning is automatically applied during the training process to select optimal hyperparameters, such as learning rate, dropout, and activation functions.
**Step 6: Evaluate the Model**
After training, the code outputs performance metrics, including:
•	Accuracy
•	Sensitivity
•	Specificity
•	F1-score
•	Precision
________________________________________

📊 **Results**

The proposed framework achieved the following performance metrics:

•	Accuracy: 91.3%
•	Sensitivity: 89.2%
•	Specificity: 92.5%
•	F1-score: 89.4%
________________________________________

⚙️** Model Details**

1. PIDSAN4 Architecture
•	Contains 107 layers optimized for recognizing leukemia cells with irregular shapes.
•	Incorporates inverted residual blocks and self-attention layers.
2. Vision Transformer (Tiny16)
•	Efficient lightweight variant for enhanced image classification tasks.
3. Hyperparameter Tuning with GWO
•	Adaptive parameter selection for improved generalization.
________________________________________

**Tip**

All the trained models are available in the github. 

📚** Citation**
If you use this repository for academic or research purposes, please cite paper



