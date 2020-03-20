WITH addr AS (
    SELECT addresses.*, concat(c.name, ',', d.name, ',', w.name, ',', addresses.street) as full_address
    FROM addresses
    left join cities c on addresses.city_id = c.id
    left join districts d on addresses.city_id = d.city_id
    left join wards w on addresses.district_id = w.district_id
)
SELECT
    CAST ('Product' AS varchar) AS searchable_type,
    p.id AS searchable_id,
    p.title AS title,
    p.product_type_id AS product_type_id,
    p.product_category_id AS product_category_id,
    p.price AS price,
    addr.city_id AS city_id,
    addr.district_id AS district_id,
    addr.ward_id AS ward_id,
    setweight(to_tsvector('english', coalesce(p.title, ' ')), 'A') ||
    setweight(to_tsvector('english', coalesce(p.description, ' ')), 'A') ||
    setweight(to_tsvector('english', coalesce(p.project, ' ')), 'B') ||
    setweight(to_tsvector('english', coalesce(p.furniture, ' ')), 'B') ||
    setweight(to_tsvector('english', coalesce(addr.full_address, ' ')), 'B')
        as document
  FROM
    products p
    JOIN addr ON p.id = addr.product_id;
