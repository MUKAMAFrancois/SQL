Create a database schema for an E-commerce Platform's Product Management System that should track:

- Products with their basic details
- Product variations (stored as JSON)
- Technical specifications (stored as JSON)
- Inventory tracking
- Product reviews
- Price history
- Attached documents (like manuals)
- Audit logging

Requirements:

1. Each product should have: ID, name, SKU, description, base price, category
2. Track stock quantity and set thresholds for low stock alerts
3. Store product variations (like size, color, material combinations)
4. Keep price change history with timestamps
5. Store customer reviews with ratings
6. Allow product specifications to be flexible (different products have different specs)
7. Store product manuals/documents
8. Track when products are created/modified and by whom
9. Support both active and discontinued products
10. Track manufacturing date and expiry date for applicable products

Your task: Design the necessary tables with appropriate data types for each field, including primary keys, and considering the relationships between tables.
