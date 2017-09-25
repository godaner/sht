package com.sht.po;

import java.util.ArrayList;
import java.util.List;

public class GoodsClazzsExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public GoodsClazzsExample() {
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

        public Criteria andIdEqualTo(Object value) {
            addCriterion("ID =", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotEqualTo(Object value) {
            addCriterion("ID <>", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThan(Object value) {
            addCriterion("ID >", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThanOrEqualTo(Object value) {
            addCriterion("ID >=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThan(Object value) {
            addCriterion("ID <", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThanOrEqualTo(Object value) {
            addCriterion("ID <=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdIn(List<Object> values) {
            addCriterion("ID in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotIn(List<Object> values) {
            addCriterion("ID not in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdBetween(Object value1, Object value2) {
            addCriterion("ID between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotBetween(Object value1, Object value2) {
            addCriterion("ID not between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andGoodsIsNull() {
            addCriterion("GOODS is null");
            return (Criteria) this;
        }

        public Criteria andGoodsIsNotNull() {
            addCriterion("GOODS is not null");
            return (Criteria) this;
        }

        public Criteria andGoodsEqualTo(Object value) {
            addCriterion("GOODS =", value, "goods");
            return (Criteria) this;
        }

        public Criteria andGoodsNotEqualTo(Object value) {
            addCriterion("GOODS <>", value, "goods");
            return (Criteria) this;
        }

        public Criteria andGoodsGreaterThan(Object value) {
            addCriterion("GOODS >", value, "goods");
            return (Criteria) this;
        }

        public Criteria andGoodsGreaterThanOrEqualTo(Object value) {
            addCriterion("GOODS >=", value, "goods");
            return (Criteria) this;
        }

        public Criteria andGoodsLessThan(Object value) {
            addCriterion("GOODS <", value, "goods");
            return (Criteria) this;
        }

        public Criteria andGoodsLessThanOrEqualTo(Object value) {
            addCriterion("GOODS <=", value, "goods");
            return (Criteria) this;
        }

        public Criteria andGoodsIn(List<Object> values) {
            addCriterion("GOODS in", values, "goods");
            return (Criteria) this;
        }

        public Criteria andGoodsNotIn(List<Object> values) {
            addCriterion("GOODS not in", values, "goods");
            return (Criteria) this;
        }

        public Criteria andGoodsBetween(Object value1, Object value2) {
            addCriterion("GOODS between", value1, value2, "goods");
            return (Criteria) this;
        }

        public Criteria andGoodsNotBetween(Object value1, Object value2) {
            addCriterion("GOODS not between", value1, value2, "goods");
            return (Criteria) this;
        }

        public Criteria andClazzIsNull() {
            addCriterion("CLAZZ is null");
            return (Criteria) this;
        }

        public Criteria andClazzIsNotNull() {
            addCriterion("CLAZZ is not null");
            return (Criteria) this;
        }

        public Criteria andClazzEqualTo(Object value) {
            addCriterion("CLAZZ =", value, "clazz");
            return (Criteria) this;
        }

        public Criteria andClazzNotEqualTo(Object value) {
            addCriterion("CLAZZ <>", value, "clazz");
            return (Criteria) this;
        }

        public Criteria andClazzGreaterThan(Object value) {
            addCriterion("CLAZZ >", value, "clazz");
            return (Criteria) this;
        }

        public Criteria andClazzGreaterThanOrEqualTo(Object value) {
            addCriterion("CLAZZ >=", value, "clazz");
            return (Criteria) this;
        }

        public Criteria andClazzLessThan(Object value) {
            addCriterion("CLAZZ <", value, "clazz");
            return (Criteria) this;
        }

        public Criteria andClazzLessThanOrEqualTo(Object value) {
            addCriterion("CLAZZ <=", value, "clazz");
            return (Criteria) this;
        }

        public Criteria andClazzIn(List<Object> values) {
            addCriterion("CLAZZ in", values, "clazz");
            return (Criteria) this;
        }

        public Criteria andClazzNotIn(List<Object> values) {
            addCriterion("CLAZZ not in", values, "clazz");
            return (Criteria) this;
        }

        public Criteria andClazzBetween(Object value1, Object value2) {
            addCriterion("CLAZZ between", value1, value2, "clazz");
            return (Criteria) this;
        }

        public Criteria andClazzNotBetween(Object value1, Object value2) {
            addCriterion("CLAZZ not between", value1, value2, "clazz");
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