# Predictive-Maintenance-for-CNC-Machine
This project involves developing a Predictive Maintenance Dashboard for CNC machines used in automotive manufacturing, aiming to improve operational efficiency, reduce downtime, and optimize maintenance schedules. The project is designed for Tata Motors and leverages advanced analytics and machine learning technique.

![image](https://github.com/user-attachments/assets/7a46a072-fb44-4bb6-b4d9-c0cf1e4b1798)


# Report on Predictive Maintenance

### Presented by Swaroop H  
**Bengaluru** | **+91-8951444547** | [swaroop5454@gmail.com](mailto:swaroop5454@gmail.com)  
[LinkedIn Profile](https://www.linkedin.com/in/swaroop5454/) | [GitHub Profile](https://github.com/swaroop5454)

---

## Problem Description

### Objective  
To develop a predictive maintenance system for CNC (Computer Numerical Control) machines at Tata Motors. CNC machines are essential in automotive manufacturing, but machine breakdowns can lead to significant downtime, high repair costs, and production delays. The goal is to predict machine failures in advance to schedule maintenance proactively, thereby improving operational efficiency, reducing unplanned downtime, and optimizing maintenance activities.

---

## Problem Statement

### Predictive Maintenance for CNC Machines  
Develop a predictive maintenance solution using real-time and historical CNC machine data (such as spindle speed, vibration levels, temperature, and operation hours) to predict potential failures. By accurately predicting these failures, the system can provide actionable insights for scheduling maintenance activities before actual machine breakdowns occur.

---

## Problem Categorization

1. **Problem Type:**  
   - This is a **Supervised Machine Learning** problem because it involves learning from labeled historical data where machine states (failure/no failure) are known.
   - Within this, it is a **Classification** problem, as the goal is to classify each time interval as "likely to fail" or "not likely to fail."

2. **Business Context and Significance:**  
   - **Industry:** Automotive Manufacturing  
   - **Domain:** Industrial IoT and Predictive Maintenance  
   - **Business Impact:** Reducing unexpected downtime, optimizing maintenance schedules, extending equipment lifespan, and minimizing repair costs.

3. **Technical Challenges:**  
   - Data Volume and Velocity: Handling large volumes of real-time sensor data from IoT devices.  
   - Data Quality: Addressing issues such as missing values, noisy sensor readings, and inconsistent sampling intervals.  
   - Complexity of Failure Patterns: Machine failures are influenced by multiple factors requiring advanced models like **LSTM** for time-series data.  

4. **Predictive Maintenance Objective:**  
   - **Binary Classification:** Classify CNC machine status as either "likely to fail" or "not likely to fail."  
   - **Time Series Analysis:** Leverage **LSTM** models to capture temporal dependencies.  

5. **Evaluation Metrics:**  
   - **Accuracy:** Overall correctness of the model.  
   - **Precision & Recall:** Ensures correct failure identification while minimizing false alarms.  
   - **F1-Score:** Balances precision and recall for class imbalance.  
   - **ROC-AUC:** Measures model discrimination ability between classes.

---

## Data Overview

The dataset contains multiple tables combined into one file:

1. **Machine Performance (Table 1):** Tracks performance metrics like Spindle_Speed_RPM, Vibration_Level, Temperature, Operation_Hours, Machine_Status, and Predicted_Failure.  
2. **Failure Logs (Table 2):** Includes Machine_ID, Failure_Type, Failure_Date, etc.  
3. **Maintenance Schedule (Table 3):** Records Technician_Name and Maintenance_Comments.  
4. **Machine Usage (Table 4):** Covers usage metrics such as Parts_Produced, Production_Quality, Rejection_Rate, and Idle_Time.  

### Data Preparation Approach

- **Separate Tables:** Split based on observed structure.  
- **Identify Target Variable:** "Predicted_Failure" in Table 1 is the target variable.  
- **Merge Tables:** Sequentially merge using Machine_ID.  
- **Data Transformation:** Handle missing values, encode categorical variables, and scale features.  

---

## Insights from the Data

### Machine Performance
1. **Spindle Speed:**  
   - Average: 4,255 RPM  
   - Highest: 4,750 RPM (CNC035)  
   - Lowest: 3,600 RPM (CNC037)  

2. **Operation Hours:**  
   - Maximum: 12 hours  
   - Minimum: 8 hours  
   - Average: 9.6 hours  

3. **Machine Status:**  
   - 50% (18 out of 35 machines) predicted to fail.

### Maintenance Trends
1. **Time Since Last Maintenance:**  
   - Machines overdue for maintenance: None.  
   - Earliest last maintenance: 101 days ago (CNC015).  

2. **Failure Rate:**  
   - Highest: 12.5%  
   - Lowest: 8.33%  

### Production Metrics
1. **Parts Produced:**  
   - Maximum: 167 parts  
   - Minimum: 133 parts  

2. **Production Quality:**  
   - High quality: 71%  
   - Medium quality: 26%  
   - Low quality: 3%  

3. **Rejection Rate:**  
   - Highest: 4.5%  
   - Lowest: 1.2%  
---
# Data Visualization

### Univariate Analysis
![image](https://github.com/user-attachments/assets/d322bc50-391d-49a8-a8a9-827b36e016d0)

 
### Density Plot:
![image](https://github.com/user-attachments/assets/841f6ecf-da2e-471e-b39a-7529d6206190)

 
### Correlation Plot:
![image](https://github.com/user-attachments/assets/2ff1311e-c152-479d-b418-35ae7f45d32c)

 
### Dimensionality Reduction using Principal Component Analysis
![image](https://github.com/user-attachments/assets/2edf5cdd-e9f1-4b63-a1e9-4dffca44f784)



## MODELLING	

Model Selection and Training:
	Random Forest: Works well with structured data and helps with feature importance.
	Support Vector Machine (SVM): Effective for binary classification.
	LSTM: If using time-series sequences, reshape your data to suit LSTM input requirements


### Random Forest:
![image](https://github.com/user-attachments/assets/565892d5-32af-4e8b-b314-6b0bb7bb10eb)

 

### Support Vector Machine (SVM)
 ![image](https://github.com/user-attachments/assets/47ad5e4d-f511-4c7b-a8bd-b58eb5616513)


---
# Conclusion

## CNC Machine Data Analysis Highlights

1. **Machine Health**  
   - Approximately **50% of machines are at risk of failure**, requiring immediate intervention.  
   - Machines such as **CNC019** show elevated vibration and temperature levels, which are primary indicators of wear and tear.

2. **Maintenance**  
   - Existing maintenance schedules are **effective**, but they can be further optimized to reduce unplanned downtime and improve resource allocation.

3. **Production Quality**  
   - The overall production quality is **high (71%)**, with **low rejection rates (2.5%)**, indicating strong operational efficiency.

4. **Downtime**  
   - Certain machines, such as **CNC010** and **CNC019**, exhibit prolonged downtime, suggesting the need for prioritized repairs and **real-time predictive maintenance** solutions.

5. **Failure Rates**  
   - Machines like **CNC002** and **CNC017** experience higher-than-average failure rates despite regular maintenance, which warrants a deeper investigation into their usage patterns or specific operational challenges.

---

## Recommendations

- Implement predictive maintenance systems.  
- Use real-time monitoring with IoT sensors.  
- Focus on reducing idle hours to enhance efficiency and minimize downtime.  
---
