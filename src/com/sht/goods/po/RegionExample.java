package com.sht.goods.po;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class RegionExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public RegionExample() {
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

        public Criteria andRegionIdIsNull() {
            addCriterion("REGION_ID is null");
            return (Criteria) this;
        }

        public Criteria andRegionIdIsNotNull() {
            addCriterion("REGION_ID is not null");
            return (Criteria) this;
        }

        public Criteria andRegionIdEqualTo(BigDecimal value) {
            addCriterion("REGION_ID =", value, "regionId");
            return (Criteria) this;
        }

        public Criteria andRegionIdNotEqualTo(BigDecimal value) {
            addCriterion("REGION_ID <>", value, "regionId");
            return (Criteria) this;
        }

        public Criteria andRegionIdGreaterThan(BigDecimal value) {
            addCriterion("REGION_ID >", value, "regionId");
            return (Criteria) this;
        }

        public Criteria andRegionIdGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("REGION_ID >=", value, "regionId");
            return (Criteria) this;
        }

        public Criteria andRegionIdLessThan(BigDecimal value) {
            addCriterion("REGION_ID <", value, "regionId");
            return (Criteria) this;
        }

        public Criteria andRegionIdLessThanOrEqualTo(BigDecimal value) {
            addCriterion("REGION_ID <=", value, "regionId");
            return (Criteria) this;
        }

        public Criteria andRegionIdIn(List<BigDecimal> values) {
            addCriterion("REGION_ID in", values, "regionId");
            return (Criteria) this;
        }

        public Criteria andRegionIdNotIn(List<BigDecimal> values) {
            addCriterion("REGION_ID not in", values, "regionId");
            return (Criteria) this;
        }

        public Criteria andRegionIdBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("REGION_ID between", value1, value2, "regionId");
            return (Criteria) this;
        }

        public Criteria andRegionIdNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("REGION_ID not between", value1, value2, "regionId");
            return (Criteria) this;
        }

        public Criteria andRegionCodeIsNull() {
            addCriterion("REGION_CODE is null");
            return (Criteria) this;
        }

        public Criteria andRegionCodeIsNotNull() {
            addCriterion("REGION_CODE is not null");
            return (Criteria) this;
        }

        public Criteria andRegionCodeEqualTo(String value) {
            addCriterion("REGION_CODE =", value, "regionCode");
            return (Criteria) this;
        }

        public Criteria andRegionCodeNotEqualTo(String value) {
            addCriterion("REGION_CODE <>", value, "regionCode");
            return (Criteria) this;
        }

        public Criteria andRegionCodeGreaterThan(String value) {
            addCriterion("REGION_CODE >", value, "regionCode");
            return (Criteria) this;
        }

        public Criteria andRegionCodeGreaterThanOrEqualTo(String value) {
            addCriterion("REGION_CODE >=", value, "regionCode");
            return (Criteria) this;
        }

        public Criteria andRegionCodeLessThan(String value) {
            addCriterion("REGION_CODE <", value, "regionCode");
            return (Criteria) this;
        }

        public Criteria andRegionCodeLessThanOrEqualTo(String value) {
            addCriterion("REGION_CODE <=", value, "regionCode");
            return (Criteria) this;
        }

        public Criteria andRegionCodeLike(String value) {
            addCriterion("REGION_CODE like", value, "regionCode");
            return (Criteria) this;
        }

        public Criteria andRegionCodeNotLike(String value) {
            addCriterion("REGION_CODE not like", value, "regionCode");
            return (Criteria) this;
        }

        public Criteria andRegionCodeIn(List<String> values) {
            addCriterion("REGION_CODE in", values, "regionCode");
            return (Criteria) this;
        }

        public Criteria andRegionCodeNotIn(List<String> values) {
            addCriterion("REGION_CODE not in", values, "regionCode");
            return (Criteria) this;
        }

        public Criteria andRegionCodeBetween(String value1, String value2) {
            addCriterion("REGION_CODE between", value1, value2, "regionCode");
            return (Criteria) this;
        }

        public Criteria andRegionCodeNotBetween(String value1, String value2) {
            addCriterion("REGION_CODE not between", value1, value2, "regionCode");
            return (Criteria) this;
        }

        public Criteria andRegionNameIsNull() {
            addCriterion("REGION_NAME is null");
            return (Criteria) this;
        }

        public Criteria andRegionNameIsNotNull() {
            addCriterion("REGION_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andRegionNameEqualTo(String value) {
            addCriterion("REGION_NAME =", value, "regionName");
            return (Criteria) this;
        }

        public Criteria andRegionNameNotEqualTo(String value) {
            addCriterion("REGION_NAME <>", value, "regionName");
            return (Criteria) this;
        }

        public Criteria andRegionNameGreaterThan(String value) {
            addCriterion("REGION_NAME >", value, "regionName");
            return (Criteria) this;
        }

        public Criteria andRegionNameGreaterThanOrEqualTo(String value) {
            addCriterion("REGION_NAME >=", value, "regionName");
            return (Criteria) this;
        }

        public Criteria andRegionNameLessThan(String value) {
            addCriterion("REGION_NAME <", value, "regionName");
            return (Criteria) this;
        }

        public Criteria andRegionNameLessThanOrEqualTo(String value) {
            addCriterion("REGION_NAME <=", value, "regionName");
            return (Criteria) this;
        }

        public Criteria andRegionNameLike(String value) {
            addCriterion("REGION_NAME like", value, "regionName");
            return (Criteria) this;
        }

        public Criteria andRegionNameNotLike(String value) {
            addCriterion("REGION_NAME not like", value, "regionName");
            return (Criteria) this;
        }

        public Criteria andRegionNameIn(List<String> values) {
            addCriterion("REGION_NAME in", values, "regionName");
            return (Criteria) this;
        }

        public Criteria andRegionNameNotIn(List<String> values) {
            addCriterion("REGION_NAME not in", values, "regionName");
            return (Criteria) this;
        }

        public Criteria andRegionNameBetween(String value1, String value2) {
            addCriterion("REGION_NAME between", value1, value2, "regionName");
            return (Criteria) this;
        }

        public Criteria andRegionNameNotBetween(String value1, String value2) {
            addCriterion("REGION_NAME not between", value1, value2, "regionName");
            return (Criteria) this;
        }

        public Criteria andParentIdIsNull() {
            addCriterion("PARENT_ID is null");
            return (Criteria) this;
        }

        public Criteria andParentIdIsNotNull() {
            addCriterion("PARENT_ID is not null");
            return (Criteria) this;
        }

        public Criteria andParentIdEqualTo(BigDecimal value) {
            addCriterion("PARENT_ID =", value, "parentId");
            return (Criteria) this;
        }

        public Criteria andParentIdNotEqualTo(BigDecimal value) {
            addCriterion("PARENT_ID <>", value, "parentId");
            return (Criteria) this;
        }

        public Criteria andParentIdGreaterThan(BigDecimal value) {
            addCriterion("PARENT_ID >", value, "parentId");
            return (Criteria) this;
        }

        public Criteria andParentIdGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("PARENT_ID >=", value, "parentId");
            return (Criteria) this;
        }

        public Criteria andParentIdLessThan(BigDecimal value) {
            addCriterion("PARENT_ID <", value, "parentId");
            return (Criteria) this;
        }

        public Criteria andParentIdLessThanOrEqualTo(BigDecimal value) {
            addCriterion("PARENT_ID <=", value, "parentId");
            return (Criteria) this;
        }

        public Criteria andParentIdIn(List<BigDecimal> values) {
            addCriterion("PARENT_ID in", values, "parentId");
            return (Criteria) this;
        }

        public Criteria andParentIdNotIn(List<BigDecimal> values) {
            addCriterion("PARENT_ID not in", values, "parentId");
            return (Criteria) this;
        }

        public Criteria andParentIdBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("PARENT_ID between", value1, value2, "parentId");
            return (Criteria) this;
        }

        public Criteria andParentIdNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("PARENT_ID not between", value1, value2, "parentId");
            return (Criteria) this;
        }

        public Criteria andRegionLevelIsNull() {
            addCriterion("REGION_LEVEL is null");
            return (Criteria) this;
        }

        public Criteria andRegionLevelIsNotNull() {
            addCriterion("REGION_LEVEL is not null");
            return (Criteria) this;
        }

        public Criteria andRegionLevelEqualTo(BigDecimal value) {
            addCriterion("REGION_LEVEL =", value, "regionLevel");
            return (Criteria) this;
        }

        public Criteria andRegionLevelNotEqualTo(BigDecimal value) {
            addCriterion("REGION_LEVEL <>", value, "regionLevel");
            return (Criteria) this;
        }

        public Criteria andRegionLevelGreaterThan(BigDecimal value) {
            addCriterion("REGION_LEVEL >", value, "regionLevel");
            return (Criteria) this;
        }

        public Criteria andRegionLevelGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("REGION_LEVEL >=", value, "regionLevel");
            return (Criteria) this;
        }

        public Criteria andRegionLevelLessThan(BigDecimal value) {
            addCriterion("REGION_LEVEL <", value, "regionLevel");
            return (Criteria) this;
        }

        public Criteria andRegionLevelLessThanOrEqualTo(BigDecimal value) {
            addCriterion("REGION_LEVEL <=", value, "regionLevel");
            return (Criteria) this;
        }

        public Criteria andRegionLevelIn(List<BigDecimal> values) {
            addCriterion("REGION_LEVEL in", values, "regionLevel");
            return (Criteria) this;
        }

        public Criteria andRegionLevelNotIn(List<BigDecimal> values) {
            addCriterion("REGION_LEVEL not in", values, "regionLevel");
            return (Criteria) this;
        }

        public Criteria andRegionLevelBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("REGION_LEVEL between", value1, value2, "regionLevel");
            return (Criteria) this;
        }

        public Criteria andRegionLevelNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("REGION_LEVEL not between", value1, value2, "regionLevel");
            return (Criteria) this;
        }

        public Criteria andRegionOrderIsNull() {
            addCriterion("REGION_ORDER is null");
            return (Criteria) this;
        }

        public Criteria andRegionOrderIsNotNull() {
            addCriterion("REGION_ORDER is not null");
            return (Criteria) this;
        }

        public Criteria andRegionOrderEqualTo(BigDecimal value) {
            addCriterion("REGION_ORDER =", value, "regionOrder");
            return (Criteria) this;
        }

        public Criteria andRegionOrderNotEqualTo(BigDecimal value) {
            addCriterion("REGION_ORDER <>", value, "regionOrder");
            return (Criteria) this;
        }

        public Criteria andRegionOrderGreaterThan(BigDecimal value) {
            addCriterion("REGION_ORDER >", value, "regionOrder");
            return (Criteria) this;
        }

        public Criteria andRegionOrderGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("REGION_ORDER >=", value, "regionOrder");
            return (Criteria) this;
        }

        public Criteria andRegionOrderLessThan(BigDecimal value) {
            addCriterion("REGION_ORDER <", value, "regionOrder");
            return (Criteria) this;
        }

        public Criteria andRegionOrderLessThanOrEqualTo(BigDecimal value) {
            addCriterion("REGION_ORDER <=", value, "regionOrder");
            return (Criteria) this;
        }

        public Criteria andRegionOrderIn(List<BigDecimal> values) {
            addCriterion("REGION_ORDER in", values, "regionOrder");
            return (Criteria) this;
        }

        public Criteria andRegionOrderNotIn(List<BigDecimal> values) {
            addCriterion("REGION_ORDER not in", values, "regionOrder");
            return (Criteria) this;
        }

        public Criteria andRegionOrderBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("REGION_ORDER between", value1, value2, "regionOrder");
            return (Criteria) this;
        }

        public Criteria andRegionOrderNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("REGION_ORDER not between", value1, value2, "regionOrder");
            return (Criteria) this;
        }

        public Criteria andRegionNameEnIsNull() {
            addCriterion("REGION_NAME_EN is null");
            return (Criteria) this;
        }

        public Criteria andRegionNameEnIsNotNull() {
            addCriterion("REGION_NAME_EN is not null");
            return (Criteria) this;
        }

        public Criteria andRegionNameEnEqualTo(String value) {
            addCriterion("REGION_NAME_EN =", value, "regionNameEn");
            return (Criteria) this;
        }

        public Criteria andRegionNameEnNotEqualTo(String value) {
            addCriterion("REGION_NAME_EN <>", value, "regionNameEn");
            return (Criteria) this;
        }

        public Criteria andRegionNameEnGreaterThan(String value) {
            addCriterion("REGION_NAME_EN >", value, "regionNameEn");
            return (Criteria) this;
        }

        public Criteria andRegionNameEnGreaterThanOrEqualTo(String value) {
            addCriterion("REGION_NAME_EN >=", value, "regionNameEn");
            return (Criteria) this;
        }

        public Criteria andRegionNameEnLessThan(String value) {
            addCriterion("REGION_NAME_EN <", value, "regionNameEn");
            return (Criteria) this;
        }

        public Criteria andRegionNameEnLessThanOrEqualTo(String value) {
            addCriterion("REGION_NAME_EN <=", value, "regionNameEn");
            return (Criteria) this;
        }

        public Criteria andRegionNameEnLike(String value) {
            addCriterion("REGION_NAME_EN like", value, "regionNameEn");
            return (Criteria) this;
        }

        public Criteria andRegionNameEnNotLike(String value) {
            addCriterion("REGION_NAME_EN not like", value, "regionNameEn");
            return (Criteria) this;
        }

        public Criteria andRegionNameEnIn(List<String> values) {
            addCriterion("REGION_NAME_EN in", values, "regionNameEn");
            return (Criteria) this;
        }

        public Criteria andRegionNameEnNotIn(List<String> values) {
            addCriterion("REGION_NAME_EN not in", values, "regionNameEn");
            return (Criteria) this;
        }

        public Criteria andRegionNameEnBetween(String value1, String value2) {
            addCriterion("REGION_NAME_EN between", value1, value2, "regionNameEn");
            return (Criteria) this;
        }

        public Criteria andRegionNameEnNotBetween(String value1, String value2) {
            addCriterion("REGION_NAME_EN not between", value1, value2, "regionNameEn");
            return (Criteria) this;
        }

        public Criteria andRegionShortnameEnIsNull() {
            addCriterion("REGION_SHORTNAME_EN is null");
            return (Criteria) this;
        }

        public Criteria andRegionShortnameEnIsNotNull() {
            addCriterion("REGION_SHORTNAME_EN is not null");
            return (Criteria) this;
        }

        public Criteria andRegionShortnameEnEqualTo(String value) {
            addCriterion("REGION_SHORTNAME_EN =", value, "regionShortnameEn");
            return (Criteria) this;
        }

        public Criteria andRegionShortnameEnNotEqualTo(String value) {
            addCriterion("REGION_SHORTNAME_EN <>", value, "regionShortnameEn");
            return (Criteria) this;
        }

        public Criteria andRegionShortnameEnGreaterThan(String value) {
            addCriterion("REGION_SHORTNAME_EN >", value, "regionShortnameEn");
            return (Criteria) this;
        }

        public Criteria andRegionShortnameEnGreaterThanOrEqualTo(String value) {
            addCriterion("REGION_SHORTNAME_EN >=", value, "regionShortnameEn");
            return (Criteria) this;
        }

        public Criteria andRegionShortnameEnLessThan(String value) {
            addCriterion("REGION_SHORTNAME_EN <", value, "regionShortnameEn");
            return (Criteria) this;
        }

        public Criteria andRegionShortnameEnLessThanOrEqualTo(String value) {
            addCriterion("REGION_SHORTNAME_EN <=", value, "regionShortnameEn");
            return (Criteria) this;
        }

        public Criteria andRegionShortnameEnLike(String value) {
            addCriterion("REGION_SHORTNAME_EN like", value, "regionShortnameEn");
            return (Criteria) this;
        }

        public Criteria andRegionShortnameEnNotLike(String value) {
            addCriterion("REGION_SHORTNAME_EN not like", value, "regionShortnameEn");
            return (Criteria) this;
        }

        public Criteria andRegionShortnameEnIn(List<String> values) {
            addCriterion("REGION_SHORTNAME_EN in", values, "regionShortnameEn");
            return (Criteria) this;
        }

        public Criteria andRegionShortnameEnNotIn(List<String> values) {
            addCriterion("REGION_SHORTNAME_EN not in", values, "regionShortnameEn");
            return (Criteria) this;
        }

        public Criteria andRegionShortnameEnBetween(String value1, String value2) {
            addCriterion("REGION_SHORTNAME_EN between", value1, value2, "regionShortnameEn");
            return (Criteria) this;
        }

        public Criteria andRegionShortnameEnNotBetween(String value1, String value2) {
            addCriterion("REGION_SHORTNAME_EN not between", value1, value2, "regionShortnameEn");
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