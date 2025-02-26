# 🍕 Pizza Sales Analysis Project

## 📋 **Project Overview**
This project analyzes a pizza sales dataset to uncover key business insights using SQL. The analysis focuses on understanding revenue trends, customer preferences,
top-selling pizzas, and operational patterns that can drive better business decisions.

---

## 🛠️ **Tools & Technologies**
- **SQL:** For querying and analyzing the dataset
- **GitHub:** For project version control and showcasing
- **PowerPoint:** For visual presentation of insights

---

## 🗃️ **Dataset Description**
The dataset consists of four interconnected tables:

1. **order_details:** Contains `order_details_id`, `order_id`, `pizza_id`, `quantity`
2. **orders:** Contains `order_id`, `date`, `time`
3. **pizza_types:** Contains `pizza_type_id`, `name`, `category`, `ingredients`
4. **pizzas:** Contains `pizza_id`, `pizza_type_id`, `size`, `price`

Entity-Relationship (ER) connections:
- `orders` ↔ `order_details` (order_id)
- `pizzas` ↔ `order_details` (pizza_id)
- `pizza_types` ↔ `pizzas` (pizza_type_id)

---

## 🔍 **Key Business Questions Answered**
- What is the total revenue generated from pizza sales?
- Which pizza size is most commonly ordered?
- What are the top 3 most ordered pizza types based on revenue?
- Which days of the week have the highest orders and revenue?
- What pizza combinations are frequently ordered together?

---

## 💡 **Key Insights**
- 🍕 **Large (L)** size pizzas are the most popular, indicating preference for shareable portions.
- 🏆 **Chicken-based pizzas** generate the highest revenue.
- 📅 **Fridays** contribute 16.64% to total weekly revenue, indicating weekend dining preferences.
- 🍽️ **Hawaiian & Thai Chicken Pizza** frequently ordered together, suggesting successful combo opportunities.

---

## 📝 **SQL Techniques Used**
- Aggregate functions: `COUNT()`, `SUM()`, `ROUND()`
- Data grouping: `GROUP BY`, `ORDER BY`
- Data filtering: `WHERE` clauses
- Joining tables: `INNER JOIN`, `SELF JOIN`
- Ranking and limiting results: `ORDER BY DESC`, `LIMIT`
- Window functions for cumulative calculations

---

## 📂 **Project Structure**
```
📦 pizza-sales-sql-analysis
 ┣ 📜 pizza_sales_queries.sql       # All SQL queries used for analysis
 ┣ 📊 Pizza_Sales_Analysis_PPT.pdf   # PowerPoint presentation with insights
 ┗ 📄 README.md                      # Project documentation (this file)
```

---

## 💬 **How to Use**
1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/pizza-sales-sql-analysis.git
   ```
2. Open `pizza_sales_queries.sql` in any SQL IDE (MySQL Workbench, pgAdmin, etc.).
3. Run queries step by step to explore the analysis results.

---

## 📈 **Insights Presentation**
The accompanying PowerPoint presentation provides:
- Visual graphs of revenue trends
- Key takeaways from SQL analysis
- Business recommendations based on data insights

---

## 💡 **Business Recommendations**
- Introduce **combo offers** with frequently paired pizzas.
- Launch **weekend deals** targeting peak sales on Fridays.
- Focus marketing on **chicken-based pizzas** due to high revenue contribution.
- Offer **family-sized promotions** to leverage the popularity of large pizzas.

---

## 🙌 **Author**
**MOHD. KHAJA PASHA**  
Data Analyst | SQL Enthusiast | Data Storyteller

🔗 *Connect with me on [LinkedIn](https://www.linkedin.com/)*  
✨ *“A taste for pizza, a hunger for insights.”* 🍕
