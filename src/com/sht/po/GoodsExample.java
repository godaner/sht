package com.sht.po;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class GoodsExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public GoodsExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andIdIsNull() {
            addCriterion("ID is null");
            return (Criteria) this;
        }

        public Criteria andIdIsNotNull() {
            addCriterion("ID is not null");
            return (Criteria) this;
        }

        public Criteria andIdEqualTo(String value) {
            addCriterion("ID =", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotEqualTo(String value) {
            addCriterion("ID <>", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThan(String value) {
            addCriterion("ID >", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThanOrEqualTo(String value) {
            addCriterion("ID >=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThan(String value) {
            addCriterion("ID <", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThanOrEqualTo(String value) {
            addCriterion("ID <=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdIn(List<String> values) {
            addCriterion("ID in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotIn(List<String> values) {
            addCriterion("ID not in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdBetween(String value1, String value2) {
            addCriterion("ID between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotBetween(String value1, String value2) {
            addCriterion("ID not between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andTitleIsNull() {
            addCriterion("TITLE is null");
            return (Criteria) this;
        }

        public Criteria andTitleIsNotNull() {
            addCriterion("TITLE is not null");
            return (Criteria) this;
        }

        public Criteria andTitleEqualTo(String value) {
            addCriterion("TITLE =", value, "title");
            return (Criteria) this;
        }

        public Criteria andTitleNotEqualTo(String value) {
            addCriterion("TITLE <>", value, "title");
            return (Criteria) this;
        }

        public Criteria andTitleGreaterThan(String value) {
            addCriterion("TITLE >", value, "title");
            return (Criteria) this;
        }

        public Criteria andTitleGreaterThanOrEqualTo(String value) {
            addCriterion("TITLE >=", value, "title");
            return (Criteria) this;
        }

        public Criteria andTitleLessThan(String value) {
            addCriterion("TITLE <", value, "title");
            return (Criteria) this;
        }

        public Criteria andTitleLessThanOrEqualTo(String value) {
            addCriterion("TITLE <=", value, "title");
            return (Criteria) this;
        }

        public Criteria andTitleIn(List<String> values) {
            addCriterion("TITLE in", values, "title");
            return (Criteria) this;
        }

        public Criteria andTitleNotIn(List<String> values) {
            addCriterion("TITLE not in", values, "title");
            return (Criteria) this;
        }

        public Criteria andTitleBetween(String value1, String value2) {
            addCriterion("TITLE between", value1, value2, "title");
            return (Criteria) this;
        }

        public Criteria andTitleNotBetween(String value1, String value2) {
            addCriterion("TITLE not between", value1, value2, "title");
            return (Criteria) this;
        }

        public Criteria andDescriptionIsNull() {
            addCriterion("DESCRIPTION is null");
            return (Criteria) this;
        }

        public Criteria andDescriptionIsNotNull() {
            addCriterion("DESCRIPTION is not null");
            return (Criteria) this;
        }

        public Criteria andDescriptionEqualTo(String value) {
            addCriterion("DESCRIPTION =", value, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionNotEqualTo(String value) {
            addCriterion("DESCRIPTION <>", value, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionGreaterThan(String value) {
            addCriterion("DESCRIPTION >", value, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionGreaterThanOrEqualTo(String value) {
            addCriterion("DESCRIPTION >=", value, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionLessThan(String value) {
            addCriterion("DESCRIPTION <", value, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionLessThanOrEqualTo(String value) {
            addCriterion("DESCRIPTION <=", value, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionIn(List<String> values) {
            addCriterion("DESCRIPTION in", values, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionNotIn(List<String> values) {
            addCriterion("DESCRIPTION not in", values, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionBetween(String value1, String value2) {
            addCriterion("DESCRIPTION between", value1, value2, "description");
            return (Criteria) this;
        }

        public Criteria andDescriptionNotBetween(String value1, String value2) {
            addCriterion("DESCRIPTION not between", value1, value2, "description");
            return (Criteria) this;
        }

        public Criteria andSpriceIsNull() {
            addCriterion("SPRICE is null");
            return (Criteria) this;
        }

        public Criteria andSpriceIsNotNull() {
            addCriterion("SPRICE is not null");
            return (Criteria) this;
        }

        public Criteria andSpriceEqualTo(Double value) {
            addCriterion("SPRICE =", value, "sprice");
            return (Criteria) this;
        }

        public Criteria andSpriceNotEqualTo(Double value) {
            addCriterion("SPRICE <>", value, "sprice");
            return (Criteria) this;
        }

        public Criteria andSpriceGreaterThan(Double value) {
            addCriterion("SPRICE >", value, "sprice");
            return (Criteria) this;
        }

        public Criteria andSpriceGreaterThanOrEqualTo(Double value) {
            addCriterion("SPRICE >=", value, "sprice");
            return (Criteria) this;
        }

        public Criteria andSpriceLessThan(Double value) {
            addCriterion("SPRICE <", value, "sprice");
            return (Criteria) this;
        }

        public Criteria andSpriceLessThanOrEqualTo(Double value) {
            addCriterion("SPRICE <=", value, "sprice");
            return (Criteria) this;
        }

        public Criteria andSpriceIn(List<Double> values) {
            addCriterion("SPRICE in", values, "sprice");
            return (Criteria) this;
        }

        public Criteria andSpriceNotIn(List<Double> values) {
            addCriterion("SPRICE not in", values, "sprice");
            return (Criteria) this;
        }

        public Criteria andSpriceBetween(Double value1, Double value2) {
            addCriterion("SPRICE between", value1, value2, "sprice");
            return (Criteria) this;
        }

        public Criteria andSpriceNotBetween(Double value1, Double value2) {
            addCriterion("SPRICE not between", value1, value2, "sprice");
            return (Criteria) this;
        }

        public Criteria andPriceIsNull() {
            addCriterion("PRICE is null");
            return (Criteria) this;
        }

        public Criteria andPriceIsNotNull() {
            addCriterion("PRICE is not null");
            return (Criteria) this;
        }

        public Criteria andPriceEqualTo(Double value) {
            addCriterion("PRICE =", value, "price");
            return (Criteria) this;
        }

        public Criteria andPriceNotEqualTo(Double value) {
            addCriterion("PRICE <>", value, "price");
            return (Criteria) this;
        }

        public Criteria andPriceGreaterThan(Double value) {
            addCriterion("PRICE >", value, "price");
            return (Criteria) this;
        }

        public Criteria andPriceGreaterThanOrEqualTo(Double value) {
            addCriterion("PRICE >=", value, "price");
            return (Criteria) this;
        }

        public Criteria andPriceLessThan(Double value) {
            addCriterion("PRICE <", value, "price");
            return (Criteria) this;
        }

        public Criteria andPriceLessThanOrEqualTo(Double value) {
            addCriterion("PRICE <=", value, "price");
            return (Criteria) this;
        }

        public Criteria andPriceIn(List<Double> values) {
            addCriterion("PRICE in", values, "price");
            return (Criteria) this;
        }

        public Criteria andPriceNotIn(List<Double> values) {
            addCriterion("PRICE not in", values, "price");
            return (Criteria) this;
        }

        public Criteria andPriceBetween(Double value1, Double value2) {
            addCriterion("PRICE between", value1, value2, "price");
            return (Criteria) this;
        }

        public Criteria andPriceNotBetween(Double value1, Double value2) {
            addCriterion("PRICE not between", value1, value2, "price");
            return (Criteria) this;
        }

        public Criteria andConditionIsNull() {
            addCriterion("CONDITION is null");
            return (Criteria) this;
        }

        public Criteria andConditionIsNotNull() {
            addCriterion("CONDITION is not null");
            return (Criteria) this;
        }

        public Criteria andConditionEqualTo(Short value) {
            addCriterion("CONDITION =", value, "condition");
            return (Criteria) this;
        }

        public Criteria andConditionNotEqualTo(Short value) {
            addCriterion("CONDITION <>", value, "condition");
            return (Criteria) this;
        }

        public Criteria andConditionGreaterThan(Short value) {
            addCriterion("CONDITION >", value, "condition");
            return (Criteria) this;
        }

        public Criteria andConditionGreaterThanOrEqualTo(Short value) {
            addCriterion("CONDITION >=", value, "condition");
            return (Criteria) this;
        }

        public Criteria andConditionLessThan(Short value) {
            addCriterion("CONDITION <", value, "condition");
            return (Criteria) this;
        }

        public Criteria andConditionLessThanOrEqualTo(Short value) {
            addCriterion("CONDITION <=", value, "condition");
            return (Criteria) this;
        }

        public Criteria andConditionIn(List<Short> values) {
            addCriterion("CONDITION in", values, "condition");
            return (Criteria) this;
        }

        public Criteria andConditionNotIn(List<Short> values) {
            addCriterion("CONDITION not in", values, "condition");
            return (Criteria) this;
        }

        public Criteria andConditionBetween(Short value1, Short value2) {
            addCriterion("CONDITION between", value1, value2, "condition");
            return (Criteria) this;
        }

        public Criteria andConditionNotBetween(Short value1, Short value2) {
            addCriterion("CONDITION not between", value1, value2, "condition");
            return (Criteria) this;
        }

        public Criteria andRegionIsNull() {
            addCriterion("REGION is null");
            return (Criteria) this;
        }

        public Criteria andRegionIsNotNull() {
            addCriterion("REGION is not null");
            return (Criteria) this;
        }

        public Criteria andRegionEqualTo(Double value) {
            addCriterion("REGION =", value, "region");
            return (Criteria) this;
        }

        public Criteria andRegionNotEqualTo(Double value) {
            addCriterion("REGION <>", value, "region");
            return (Criteria) this;
        }

        public Criteria andRegionGreaterThan(Double value) {
            addCriterion("REGION >", value, "region");
            return (Criteria) this;
        }

        public Criteria andRegionGreaterThanOrEqualTo(Double value) {
            addCriterion("REGION >=", value, "region");
            return (Criteria) this;
        }

        public Criteria andRegionLessThan(Double value) {
            addCriterion("REGION <", value, "region");
            return (Criteria) this;
        }

        public Criteria andRegionLessThanOrEqualTo(Double value) {
            addCriterion("REGION <=", value, "region");
            return (Criteria) this;
        }

        public Criteria andRegionIn(List<Double> values) {
            addCriterion("REGION in", values, "region");
            return (Criteria) this;
        }

        public Criteria andRegionNotIn(List<Double> values) {
            addCriterion("REGION not in", values, "region");
            return (Criteria) this;
        }

        public Criteria andRegionBetween(Double value1, Double value2) {
            addCriterion("REGION between", value1, value2, "region");
            return (Criteria) this;
        }

        public Criteria andRegionNotBetween(Double value1, Double value2) {
            addCriterion("REGION not between", value1, value2, "region");
            return (Criteria) this;
        }

        public Criteria andStatusIsNull() {
            addCriterion("STATUS is null");
            return (Criteria) this;
        }

        public Criteria andStatusIsNotNull() {
            addCriterion("STATUS is not null");
            return (Criteria) this;
        }

        public Criteria andStatusEqualTo(Short value) {
            addCriterion("STATUS =", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusNotEqualTo(Short value) {
            addCriterion("STATUS <>", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusGreaterThan(Short value) {
            addCriterion("STATUS >", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusGreaterThanOrEqualTo(Short value) {
            addCriterion("STATUS >=", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusLessThan(Short value) {
            addCriterion("STATUS <", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusLessThanOrEqualTo(Short value) {
            addCriterion("STATUS <=", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusIn(List<Short> values) {
            addCriterion("STATUS in", values, "status");
            return (Criteria) this;
        }

        public Criteria andStatusNotIn(List<Short> values) {
            addCriterion("STATUS not in", values, "status");
            return (Criteria) this;
        }

        public Criteria andStatusBetween(Short value1, Short value2) {
            addCriterion("STATUS between", value1, value2, "status");
            return (Criteria) this;
        }

        public Criteria andStatusNotBetween(Short value1, Short value2) {
            addCriterion("STATUS not between", value1, value2, "status");
            return (Criteria) this;
        }

        public Criteria andCreatetimeIsNull() {
            addCriterion("CREATETIME is null");
            return (Criteria) this;
        }

        public Criteria andCreatetimeIsNotNull() {
            addCriterion("CREATETIME is not null");
            return (Criteria) this;
        }

        public Criteria andCreatetimeEqualTo(Timestamp value) {
            addCriterion("CREATETIME =", value, "createtime");
            return (Criteria) this;
        }

        public Criteria andCreatetimeNotEqualTo(Timestamp value) {
            addCriterion("CREATETIME <>", value, "createtime");
            return (Criteria) this;
        }

        public Criteria andCreatetimeGreaterThan(Timestamp value) {
            addCriterion("CREATETIME >", value, "createtime");
            return (Criteria) this;
        }

        public Criteria andCreatetimeGreaterThanOrEqualTo(Timestamp value) {
            addCriterion("CREATETIME >=", value, "createtime");
            return (Criteria) this;
        }

        public Criteria andCreatetimeLessThan(Timestamp value) {
            addCriterion("CREATETIME <", value, "createtime");
            return (Criteria) this;
        }

        public Criteria andCreatetimeLessThanOrEqualTo(Timestamp value) {
            addCriterion("CREATETIME <=", value, "createtime");
            return (Criteria) this;
        }

        public Criteria andCreatetimeIn(List<Timestamp> values) {
            addCriterion("CREATETIME in", values, "createtime");
            return (Criteria) this;
        }

        public Criteria andCreatetimeNotIn(List<Timestamp> values) {
            addCriterion("CREATETIME not in", values, "createtime");
            return (Criteria) this;
        }

        public Criteria andCreatetimeBetween(Timestamp value1, Timestamp value2) {
            addCriterion("CREATETIME between", value1, value2, "createtime");
            return (Criteria) this;
        }

        public Criteria andCreatetimeNotBetween(Timestamp value1, Timestamp value2) {
            addCriterion("CREATETIME not between", value1, value2, "createtime");
            return (Criteria) this;
        }

        public Criteria andOwnerIsNull() {
            addCriterion("OWNER is null");
            return (Criteria) this;
        }

        public Criteria andOwnerIsNotNull() {
            addCriterion("OWNER is not null");
            return (Criteria) this;
        }

        public Criteria andOwnerEqualTo(String value) {
            addCriterion("OWNER =", value, "owner");
            return (Criteria) this;
        }

        public Criteria andOwnerNotEqualTo(String value) {
            addCriterion("OWNER <>", value, "owner");
            return (Criteria) this;
        }

        public Criteria andOwnerGreaterThan(String value) {
            addCriterion("OWNER >", value, "owner");
            return (Criteria) this;
        }

        public Criteria andOwnerGreaterThanOrEqualTo(String value) {
            addCriterion("OWNER >=", value, "owner");
            return (Criteria) this;
        }

        public Criteria andOwnerLessThan(String value) {
            addCriterion("OWNER <", value, "owner");
            return (Criteria) this;
        }

        public Criteria andOwnerLessThanOrEqualTo(String value) {
            addCriterion("OWNER <=", value, "owner");
            return (Criteria) this;
        }

        public Criteria andOwnerIn(List<String> values) {
            addCriterion("OWNER in", values, "owner");
            return (Criteria) this;
        }

        public Criteria andOwnerNotIn(List<String> values) {
            addCriterion("OWNER not in", values, "owner");
            return (Criteria) this;
        }

        public Criteria andOwnerBetween(String value1, String value2) {
            addCriterion("OWNER between", value1, value2, "owner");
            return (Criteria) this;
        }

        public Criteria andOwnerNotBetween(String value1, String value2) {
            addCriterion("OWNER not between", value1, value2, "owner");
            return (Criteria) this;
        }

        public Criteria andBuyerIsNull() {
            addCriterion("BUYER is null");
            return (Criteria) this;
        }

        public Criteria andBuyerIsNotNull() {
            addCriterion("BUYER is not null");
            return (Criteria) this;
        }

        public Criteria andBuyerEqualTo(String value) {
            addCriterion("BUYER =", value, "buyer");
            return (Criteria) this;
        }

        public Criteria andBuyerNotEqualTo(String value) {
            addCriterion("BUYER <>", value, "buyer");
            return (Criteria) this;
        }

        public Criteria andBuyerGreaterThan(String value) {
            addCriterion("BUYER >", value, "buyer");
            return (Criteria) this;
        }

        public Criteria andBuyerGreaterThanOrEqualTo(String value) {
            addCriterion("BUYER >=", value, "buyer");
            return (Criteria) this;
        }

        public Criteria andBuyerLessThan(String value) {
            addCriterion("BUYER <", value, "buyer");
            return (Criteria) this;
        }

        public Criteria andBuyerLessThanOrEqualTo(String value) {
            addCriterion("BUYER <=", value, "buyer");
            return (Criteria) this;
        }

        public Criteria andBuyerIn(List<String> values) {
            addCriterion("BUYER in", values, "buyer");
            return (Criteria) this;
        }

        public Criteria andBuyerNotIn(List<String> values) {
            addCriterion("BUYER not in", values, "buyer");
            return (Criteria) this;
        }

        public Criteria andBuyerBetween(String value1, String value2) {
            addCriterion("BUYER between", value1, value2, "buyer");
            return (Criteria) this;
        }

        public Criteria andBuyerNotBetween(String value1, String value2) {
            addCriterion("BUYER not between", value1, value2, "buyer");
            return (Criteria) this;
        }

        public Criteria andBrowsenumberIsNull() {
            addCriterion("BROWSENUMBER is null");
            return (Criteria) this;
        }

        public Criteria andBrowsenumberIsNotNull() {
            addCriterion("BROWSENUMBER is not null");
            return (Criteria) this;
        }

        public Criteria andBrowsenumberEqualTo(Double value) {
            addCriterion("BROWSENUMBER =", value, "browsenumber");
            return (Criteria) this;
        }

        public Criteria andBrowsenumberNotEqualTo(Double value) {
            addCriterion("BROWSENUMBER <>", value, "browsenumber");
            return (Criteria) this;
        }

        public Criteria andBrowsenumberGreaterThan(Double value) {
            addCriterion("BROWSENUMBER >", value, "browsenumber");
            return (Criteria) this;
        }

        public Criteria andBrowsenumberGreaterThanOrEqualTo(Double value) {
            addCriterion("BROWSENUMBER >=", value, "browsenumber");
            return (Criteria) this;
        }

        public Criteria andBrowsenumberLessThan(Double value) {
            addCriterion("BROWSENUMBER <", value, "browsenumber");
            return (Criteria) this;
        }

        public Criteria andBrowsenumberLessThanOrEqualTo(Double value) {
            addCriterion("BROWSENUMBER <=", value, "browsenumber");
            return (Criteria) this;
        }

        public Criteria andBrowsenumberIn(List<Double> values) {
            addCriterion("BROWSENUMBER in", values, "browsenumber");
            return (Criteria) this;
        }

        public Criteria andBrowsenumberNotIn(List<Double> values) {
            addCriterion("BROWSENUMBER not in", values, "browsenumber");
            return (Criteria) this;
        }

        public Criteria andBrowsenumberBetween(Double value1, Double value2) {
            addCriterion("BROWSENUMBER between", value1, value2, "browsenumber");
            return (Criteria) this;
        }

        public Criteria andBrowsenumberNotBetween(Double value1, Double value2) {
            addCriterion("BROWSENUMBER not between", value1, value2, "browsenumber");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeIsNull() {
            addCriterion("LASTUPDATETIME is null");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeIsNotNull() {
            addCriterion("LASTUPDATETIME is not null");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeEqualTo(Timestamp value) {
            addCriterion("LASTUPDATETIME =", value, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeNotEqualTo(Timestamp value) {
            addCriterion("LASTUPDATETIME <>", value, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeGreaterThan(Timestamp value) {
            addCriterion("LASTUPDATETIME >", value, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeGreaterThanOrEqualTo(Timestamp value) {
            addCriterion("LASTUPDATETIME >=", value, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeLessThan(Timestamp value) {
            addCriterion("LASTUPDATETIME <", value, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeLessThanOrEqualTo(Timestamp value) {
            addCriterion("LASTUPDATETIME <=", value, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeIn(List<Timestamp> values) {
            addCriterion("LASTUPDATETIME in", values, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeNotIn(List<Timestamp> values) {
            addCriterion("LASTUPDATETIME not in", values, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeBetween(Timestamp value1, Timestamp value2) {
            addCriterion("LASTUPDATETIME between", value1, value2, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeNotBetween(Timestamp value1, Timestamp value2) {
            addCriterion("LASTUPDATETIME not between", value1, value2, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andBuytimeIsNull() {
            addCriterion("BUYTIME is null");
            return (Criteria) this;
        }

        public Criteria andBuytimeIsNotNull() {
            addCriterion("BUYTIME is not null");
            return (Criteria) this;
        }

        public Criteria andBuytimeEqualTo(Timestamp value) {
            addCriterion("BUYTIME =", value, "buytime");
            return (Criteria) this;
        }

        public Criteria andBuytimeNotEqualTo(Timestamp value) {
            addCriterion("BUYTIME <>", value, "buytime");
            return (Criteria) this;
        }

        public Criteria andBuytimeGreaterThan(Timestamp value) {
            addCriterion("BUYTIME >", value, "buytime");
            return (Criteria) this;
        }

        public Criteria andBuytimeGreaterThanOrEqualTo(Timestamp value) {
            addCriterion("BUYTIME >=", value, "buytime");
            return (Criteria) this;
        }

        public Criteria andBuytimeLessThan(Timestamp value) {
            addCriterion("BUYTIME <", value, "buytime");
            return (Criteria) this;
        }

        public Criteria andBuytimeLessThanOrEqualTo(Timestamp value) {
            addCriterion("BUYTIME <=", value, "buytime");
            return (Criteria) this;
        }

        public Criteria andBuytimeIn(List<Timestamp> values) {
            addCriterion("BUYTIME in", values, "buytime");
            return (Criteria) this;
        }

        public Criteria andBuytimeNotIn(List<Timestamp> values) {
            addCriterion("BUYTIME not in", values, "buytime");
            return (Criteria) this;
        }

        public Criteria andBuytimeBetween(Timestamp value1, Timestamp value2) {
            addCriterion("BUYTIME between", value1, value2, "buytime");
            return (Criteria) this;
        }

        public Criteria andBuytimeNotBetween(Timestamp value1, Timestamp value2) {
            addCriterion("BUYTIME not between", value1, value2, "buytime");
            return (Criteria) this;
        }

        public Criteria andFinishtimeIsNull() {
            addCriterion("FINISHTIME is null");
            return (Criteria) this;
        }

        public Criteria andFinishtimeIsNotNull() {
            addCriterion("FINISHTIME is not null");
            return (Criteria) this;
        }

        public Criteria andFinishtimeEqualTo(Timestamp value) {
            addCriterion("FINISHTIME =", value, "finishtime");
            return (Criteria) this;
        }

        public Criteria andFinishtimeNotEqualTo(Timestamp value) {
            addCriterion("FINISHTIME <>", value, "finishtime");
            return (Criteria) this;
        }

        public Criteria andFinishtimeGreaterThan(Timestamp value) {
            addCriterion("FINISHTIME >", value, "finishtime");
            return (Criteria) this;
        }

        public Criteria andFinishtimeGreaterThanOrEqualTo(Timestamp value) {
            addCriterion("FINISHTIME >=", value, "finishtime");
            return (Criteria) this;
        }

        public Criteria andFinishtimeLessThan(Timestamp value) {
            addCriterion("FINISHTIME <", value, "finishtime");
            return (Criteria) this;
        }

        public Criteria andFinishtimeLessThanOrEqualTo(Timestamp value) {
            addCriterion("FINISHTIME <=", value, "finishtime");
            return (Criteria) this;
        }

        public Criteria andFinishtimeIn(List<Timestamp> values) {
            addCriterion("FINISHTIME in", values, "finishtime");
            return (Criteria) this;
        }

        public Criteria andFinishtimeNotIn(List<Timestamp> values) {
            addCriterion("FINISHTIME not in", values, "finishtime");
            return (Criteria) this;
        }

        public Criteria andFinishtimeBetween(Timestamp value1, Timestamp value2) {
            addCriterion("FINISHTIME between", value1, value2, "finishtime");
            return (Criteria) this;
        }

        public Criteria andFinishtimeNotBetween(Timestamp value1, Timestamp value2) {
            addCriterion("FINISHTIME not between", value1, value2, "finishtime");
            return (Criteria) this;
        }

        public Criteria andToprovinceIsNull() {
            addCriterion("TOPROVINCE is null");
            return (Criteria) this;
        }

        public Criteria andToprovinceIsNotNull() {
            addCriterion("TOPROVINCE is not null");
            return (Criteria) this;
        }

        public Criteria andToprovinceEqualTo(String value) {
            addCriterion("TOPROVINCE =", value, "toprovince");
            return (Criteria) this;
        }

        public Criteria andToprovinceNotEqualTo(String value) {
            addCriterion("TOPROVINCE <>", value, "toprovince");
            return (Criteria) this;
        }

        public Criteria andToprovinceGreaterThan(String value) {
            addCriterion("TOPROVINCE >", value, "toprovince");
            return (Criteria) this;
        }

        public Criteria andToprovinceGreaterThanOrEqualTo(String value) {
            addCriterion("TOPROVINCE >=", value, "toprovince");
            return (Criteria) this;
        }

        public Criteria andToprovinceLessThan(String value) {
            addCriterion("TOPROVINCE <", value, "toprovince");
            return (Criteria) this;
        }

        public Criteria andToprovinceLessThanOrEqualTo(String value) {
            addCriterion("TOPROVINCE <=", value, "toprovince");
            return (Criteria) this;
        }

        public Criteria andToprovinceIn(List<String> values) {
            addCriterion("TOPROVINCE in", values, "toprovince");
            return (Criteria) this;
        }

        public Criteria andToprovinceNotIn(List<String> values) {
            addCriterion("TOPROVINCE not in", values, "toprovince");
            return (Criteria) this;
        }

        public Criteria andToprovinceBetween(String value1, String value2) {
            addCriterion("TOPROVINCE between", value1, value2, "toprovince");
            return (Criteria) this;
        }

        public Criteria andToprovinceNotBetween(String value1, String value2) {
            addCriterion("TOPROVINCE not between", value1, value2, "toprovince");
            return (Criteria) this;
        }

        public Criteria andTocityIsNull() {
            addCriterion("TOCITY is null");
            return (Criteria) this;
        }

        public Criteria andTocityIsNotNull() {
            addCriterion("TOCITY is not null");
            return (Criteria) this;
        }

        public Criteria andTocityEqualTo(String value) {
            addCriterion("TOCITY =", value, "tocity");
            return (Criteria) this;
        }

        public Criteria andTocityNotEqualTo(String value) {
            addCriterion("TOCITY <>", value, "tocity");
            return (Criteria) this;
        }

        public Criteria andTocityGreaterThan(String value) {
            addCriterion("TOCITY >", value, "tocity");
            return (Criteria) this;
        }

        public Criteria andTocityGreaterThanOrEqualTo(String value) {
            addCriterion("TOCITY >=", value, "tocity");
            return (Criteria) this;
        }

        public Criteria andTocityLessThan(String value) {
            addCriterion("TOCITY <", value, "tocity");
            return (Criteria) this;
        }

        public Criteria andTocityLessThanOrEqualTo(String value) {
            addCriterion("TOCITY <=", value, "tocity");
            return (Criteria) this;
        }

        public Criteria andTocityIn(List<String> values) {
            addCriterion("TOCITY in", values, "tocity");
            return (Criteria) this;
        }

        public Criteria andTocityNotIn(List<String> values) {
            addCriterion("TOCITY not in", values, "tocity");
            return (Criteria) this;
        }

        public Criteria andTocityBetween(String value1, String value2) {
            addCriterion("TOCITY between", value1, value2, "tocity");
            return (Criteria) this;
        }

        public Criteria andTocityNotBetween(String value1, String value2) {
            addCriterion("TOCITY not between", value1, value2, "tocity");
            return (Criteria) this;
        }

        public Criteria andTocountyIsNull() {
            addCriterion("TOCOUNTY is null");
            return (Criteria) this;
        }

        public Criteria andTocountyIsNotNull() {
            addCriterion("TOCOUNTY is not null");
            return (Criteria) this;
        }

        public Criteria andTocountyEqualTo(String value) {
            addCriterion("TOCOUNTY =", value, "tocounty");
            return (Criteria) this;
        }

        public Criteria andTocountyNotEqualTo(String value) {
            addCriterion("TOCOUNTY <>", value, "tocounty");
            return (Criteria) this;
        }

        public Criteria andTocountyGreaterThan(String value) {
            addCriterion("TOCOUNTY >", value, "tocounty");
            return (Criteria) this;
        }

        public Criteria andTocountyGreaterThanOrEqualTo(String value) {
            addCriterion("TOCOUNTY >=", value, "tocounty");
            return (Criteria) this;
        }

        public Criteria andTocountyLessThan(String value) {
            addCriterion("TOCOUNTY <", value, "tocounty");
            return (Criteria) this;
        }

        public Criteria andTocountyLessThanOrEqualTo(String value) {
            addCriterion("TOCOUNTY <=", value, "tocounty");
            return (Criteria) this;
        }

        public Criteria andTocountyIn(List<String> values) {
            addCriterion("TOCOUNTY in", values, "tocounty");
            return (Criteria) this;
        }

        public Criteria andTocountyNotIn(List<String> values) {
            addCriterion("TOCOUNTY not in", values, "tocounty");
            return (Criteria) this;
        }

        public Criteria andTocountyBetween(String value1, String value2) {
            addCriterion("TOCOUNTY between", value1, value2, "tocounty");
            return (Criteria) this;
        }

        public Criteria andTocountyNotBetween(String value1, String value2) {
            addCriterion("TOCOUNTY not between", value1, value2, "tocounty");
            return (Criteria) this;
        }

        public Criteria andTodetailIsNull() {
            addCriterion("TODETAIL is null");
            return (Criteria) this;
        }

        public Criteria andTodetailIsNotNull() {
            addCriterion("TODETAIL is not null");
            return (Criteria) this;
        }

        public Criteria andTodetailEqualTo(String value) {
            addCriterion("TODETAIL =", value, "todetail");
            return (Criteria) this;
        }

        public Criteria andTodetailNotEqualTo(String value) {
            addCriterion("TODETAIL <>", value, "todetail");
            return (Criteria) this;
        }

        public Criteria andTodetailGreaterThan(String value) {
            addCriterion("TODETAIL >", value, "todetail");
            return (Criteria) this;
        }

        public Criteria andTodetailGreaterThanOrEqualTo(String value) {
            addCriterion("TODETAIL >=", value, "todetail");
            return (Criteria) this;
        }

        public Criteria andTodetailLessThan(String value) {
            addCriterion("TODETAIL <", value, "todetail");
            return (Criteria) this;
        }

        public Criteria andTodetailLessThanOrEqualTo(String value) {
            addCriterion("TODETAIL <=", value, "todetail");
            return (Criteria) this;
        }

        public Criteria andTodetailIn(List<String> values) {
            addCriterion("TODETAIL in", values, "todetail");
            return (Criteria) this;
        }

        public Criteria andTodetailNotIn(List<String> values) {
            addCriterion("TODETAIL not in", values, "todetail");
            return (Criteria) this;
        }

        public Criteria andTodetailBetween(String value1, String value2) {
            addCriterion("TODETAIL between", value1, value2, "todetail");
            return (Criteria) this;
        }

        public Criteria andTodetailNotBetween(String value1, String value2) {
            addCriterion("TODETAIL not between", value1, value2, "todetail");
            return (Criteria) this;
        }

        public Criteria andPhoneIsNull() {
            addCriterion("PHONE is null");
            return (Criteria) this;
        }

        public Criteria andPhoneIsNotNull() {
            addCriterion("PHONE is not null");
            return (Criteria) this;
        }

        public Criteria andPhoneEqualTo(String value) {
            addCriterion("PHONE =", value, "phone");
            return (Criteria) this;
        }

        public Criteria andPhoneNotEqualTo(String value) {
            addCriterion("PHONE <>", value, "phone");
            return (Criteria) this;
        }

        public Criteria andPhoneGreaterThan(String value) {
            addCriterion("PHONE >", value, "phone");
            return (Criteria) this;
        }

        public Criteria andPhoneGreaterThanOrEqualTo(String value) {
            addCriterion("PHONE >=", value, "phone");
            return (Criteria) this;
        }

        public Criteria andPhoneLessThan(String value) {
            addCriterion("PHONE <", value, "phone");
            return (Criteria) this;
        }

        public Criteria andPhoneLessThanOrEqualTo(String value) {
            addCriterion("PHONE <=", value, "phone");
            return (Criteria) this;
        }

        public Criteria andPhoneIn(List<String> values) {
            addCriterion("PHONE in", values, "phone");
            return (Criteria) this;
        }

        public Criteria andPhoneNotIn(List<String> values) {
            addCriterion("PHONE not in", values, "phone");
            return (Criteria) this;
        }

        public Criteria andPhoneBetween(String value1, String value2) {
            addCriterion("PHONE between", value1, value2, "phone");
            return (Criteria) this;
        }

        public Criteria andPhoneNotBetween(String value1, String value2) {
            addCriterion("PHONE not between", value1, value2, "phone");
            return (Criteria) this;
        }

        public Criteria andTorealnameIsNull() {
            addCriterion("TOREALNAME is null");
            return (Criteria) this;
        }

        public Criteria andTorealnameIsNotNull() {
            addCriterion("TOREALNAME is not null");
            return (Criteria) this;
        }

        public Criteria andTorealnameEqualTo(String value) {
            addCriterion("TOREALNAME =", value, "torealname");
            return (Criteria) this;
        }

        public Criteria andTorealnameNotEqualTo(String value) {
            addCriterion("TOREALNAME <>", value, "torealname");
            return (Criteria) this;
        }

        public Criteria andTorealnameGreaterThan(String value) {
            addCriterion("TOREALNAME >", value, "torealname");
            return (Criteria) this;
        }

        public Criteria andTorealnameGreaterThanOrEqualTo(String value) {
            addCriterion("TOREALNAME >=", value, "torealname");
            return (Criteria) this;
        }

        public Criteria andTorealnameLessThan(String value) {
            addCriterion("TOREALNAME <", value, "torealname");
            return (Criteria) this;
        }

        public Criteria andTorealnameLessThanOrEqualTo(String value) {
            addCriterion("TOREALNAME <=", value, "torealname");
            return (Criteria) this;
        }

        public Criteria andTorealnameIn(List<String> values) {
            addCriterion("TOREALNAME in", values, "torealname");
            return (Criteria) this;
        }

        public Criteria andTorealnameNotIn(List<String> values) {
            addCriterion("TOREALNAME not in", values, "torealname");
            return (Criteria) this;
        }

        public Criteria andTorealnameBetween(String value1, String value2) {
            addCriterion("TOREALNAME between", value1, value2, "torealname");
            return (Criteria) this;
        }

        public Criteria andTorealnameNotBetween(String value1, String value2) {
            addCriterion("TOREALNAME not between", value1, value2, "torealname");
            return (Criteria) this;
        }

        public Criteria andPostcodeIsNull() {
            addCriterion("POSTCODE is null");
            return (Criteria) this;
        }

        public Criteria andPostcodeIsNotNull() {
            addCriterion("POSTCODE is not null");
            return (Criteria) this;
        }

        public Criteria andPostcodeEqualTo(String value) {
            addCriterion("POSTCODE =", value, "postcode");
            return (Criteria) this;
        }

        public Criteria andPostcodeNotEqualTo(String value) {
            addCriterion("POSTCODE <>", value, "postcode");
            return (Criteria) this;
        }

        public Criteria andPostcodeGreaterThan(String value) {
            addCriterion("POSTCODE >", value, "postcode");
            return (Criteria) this;
        }

        public Criteria andPostcodeGreaterThanOrEqualTo(String value) {
            addCriterion("POSTCODE >=", value, "postcode");
            return (Criteria) this;
        }

        public Criteria andPostcodeLessThan(String value) {
            addCriterion("POSTCODE <", value, "postcode");
            return (Criteria) this;
        }

        public Criteria andPostcodeLessThanOrEqualTo(String value) {
            addCriterion("POSTCODE <=", value, "postcode");
            return (Criteria) this;
        }

        public Criteria andPostcodeIn(List<String> values) {
            addCriterion("POSTCODE in", values, "postcode");
            return (Criteria) this;
        }

        public Criteria andPostcodeNotIn(List<String> values) {
            addCriterion("POSTCODE not in", values, "postcode");
            return (Criteria) this;
        }

        public Criteria andPostcodeBetween(String value1, String value2) {
            addCriterion("POSTCODE between", value1, value2, "postcode");
            return (Criteria) this;
        }

        public Criteria andPostcodeNotBetween(String value1, String value2) {
            addCriterion("POSTCODE not between", value1, value2, "postcode");
            return (Criteria) this;
        }

        public Criteria andRefusereturnmoneybillIsNull() {
            addCriterion("REFUSERETURNMONEYBILL is null");
            return (Criteria) this;
        }

        public Criteria andRefusereturnmoneybillIsNotNull() {
            addCriterion("REFUSERETURNMONEYBILL is not null");
            return (Criteria) this;
        }

        public Criteria andRefusereturnmoneybillEqualTo(String value) {
            addCriterion("REFUSERETURNMONEYBILL =", value, "refusereturnmoneybill");
            return (Criteria) this;
        }

        public Criteria andRefusereturnmoneybillNotEqualTo(String value) {
            addCriterion("REFUSERETURNMONEYBILL <>", value, "refusereturnmoneybill");
            return (Criteria) this;
        }

        public Criteria andRefusereturnmoneybillGreaterThan(String value) {
            addCriterion("REFUSERETURNMONEYBILL >", value, "refusereturnmoneybill");
            return (Criteria) this;
        }

        public Criteria andRefusereturnmoneybillGreaterThanOrEqualTo(String value) {
            addCriterion("REFUSERETURNMONEYBILL >=", value, "refusereturnmoneybill");
            return (Criteria) this;
        }

        public Criteria andRefusereturnmoneybillLessThan(String value) {
            addCriterion("REFUSERETURNMONEYBILL <", value, "refusereturnmoneybill");
            return (Criteria) this;
        }

        public Criteria andRefusereturnmoneybillLessThanOrEqualTo(String value) {
            addCriterion("REFUSERETURNMONEYBILL <=", value, "refusereturnmoneybill");
            return (Criteria) this;
        }

        public Criteria andRefusereturnmoneybillIn(List<String> values) {
            addCriterion("REFUSERETURNMONEYBILL in", values, "refusereturnmoneybill");
            return (Criteria) this;
        }

        public Criteria andRefusereturnmoneybillNotIn(List<String> values) {
            addCriterion("REFUSERETURNMONEYBILL not in", values, "refusereturnmoneybill");
            return (Criteria) this;
        }

        public Criteria andRefusereturnmoneybillBetween(String value1, String value2) {
            addCriterion("REFUSERETURNMONEYBILL between", value1, value2, "refusereturnmoneybill");
            return (Criteria) this;
        }

        public Criteria andRefusereturnmoneybillNotBetween(String value1, String value2) {
            addCriterion("REFUSERETURNMONEYBILL not between", value1, value2, "refusereturnmoneybill");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}