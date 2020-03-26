WITH addr AS (
    SELECT addresses.*, concat(c.name, ',', d.name, ',', w.name, ',', addresses.street) as full_address
    FROM addresses
    left join cities c on addresses.city_id = c.id
    left join districts d on addresses.district_id = d.id
    left join wards w on addresses.ward_id = w.id
), ppa AS (
    select products_product_amenities.product_id, array_agg(DISTINCT products_product_amenities.product_amenity_id) AS product_amenity_ids
    from products_product_amenities
    group by products_product_amenities.product_id
)
SELECT
    CAST ('Product' AS varchar) AS searchable_type,
    p.id AS searchable_id,
    p.title AS title,
    p.product_category_id AS product_category_id,
    ppa.product_amenity_ids,
    p.price AS price,
    p.acreage AS acreage,
    addr.city_id AS city_id,
    addr.district_id AS district_id,
    addr.ward_id AS ward_id,
    setweight(to_tsvector('english', coalesce(vn_unaccent(p.title), ' ')), 'A') ||
    setweight(to_tsvector('english', coalesce(vn_unaccent(p.description), ' ')), 'A') ||
    setweight(to_tsvector('english', coalesce(vn_unaccent(p.project), ' ')), 'B') ||
    setweight(to_tsvector('english', coalesce(vn_unaccent(p.furniture), ' ')), 'B') ||
    setweight(to_tsvector('english', coalesce(vn_unaccent(addr.full_address), ' ')), 'B')
        as document
  FROM
    products p
    LEFT OUTER JOIN addr ON p.id = addr.product_id
    LEFT OUTER JOIN ppa on p.id = ppa.product_id;
