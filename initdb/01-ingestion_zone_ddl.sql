CREATE TABLE IF NOT EXISTS landing_zone.region (
  r_regionkey NUMERIC,    
  r_name      TEXT,
  r_comment   TEXT
);

CREATE TABLE IF NOT EXISTS landing_zone.nation (
  n_nationkey NUMERIC,   
  n_name      TEXT,
  n_regionkey NUMERIC,    
  n_comment   TEXT
);


CREATE TABLE IF NOT EXISTS landing_zone.part (
  p_partkey     NUMERIC,  
  p_name        TEXT,
  p_mfgr        TEXT,
  p_brand       TEXT,
  p_type        TEXT,
  p_size        NUMERIC, 
  p_container   TEXT,
  p_retailprice NUMERIC, 
  p_comment     TEXT
);

CREATE TABLE IF NOT EXISTS landing_zone.supplier (
  s_suppkey   NUMERIC,    
  s_name      TEXT,
  s_address   TEXT,
  s_nationkey NUMERIC,    
  s_phone     TEXT,
  s_acctbal   NUMERIC,    
  s_comment   TEXT
);

CREATE TABLE IF NOT EXISTS landing_zone.partsupp (
  ps_partkey    NUMERIC,  
  ps_suppkey    NUMERIC,  
  ps_availqty   NUMERIC,  
  ps_supplycost NUMERIC,  
  ps_comment    TEXT
);

CREATE TABLE IF NOT EXISTS landing_zone.customer (
  c_custkey    NUMERIC,   
  c_name       TEXT,
  c_address    TEXT,
  c_nationkey  NUMERIC,   
  c_phone      TEXT,
  c_acctbal    NUMERIC,   
  c_mktsegment TEXT,
  c_comment    TEXT
);

CREATE TABLE IF NOT EXISTS landing_zone.orders (
  o_orderkey      NUMERIC,  
  o_custkey       NUMERIC,  
  o_orderstatus   TEXT,
  o_totalprice    NUMERIC,  
  o_orderdate     TEXT,     -- ingest dates as text
  o_orderpriority TEXT,
  o_clerk         TEXT,
  o_shippriority  NUMERIC,  
  o_comment       TEXT
);

CREATE TABLE IF NOT EXISTS landing_zone.lineitem (
  l_orderkey      NUMERIC,  
  l_partkey       NUMERIC,  
  l_suppkey       NUMERIC,  
  l_linenumber    NUMERIC,  
  l_quantity      NUMERIC,  
  l_extendedprice NUMERIC,  
  l_discount      NUMERIC,  
  l_tax           NUMERIC,  
  l_returnflag    TEXT,
  l_linestatus    TEXT,
  l_shipdate      TEXT,     
  l_commitdate    TEXT,
  l_receiptdate   TEXT,
  l_shipinstruct  TEXT,
  l_shipmode      TEXT,
  l_comment       TEXT
);