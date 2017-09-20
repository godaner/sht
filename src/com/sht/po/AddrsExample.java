package com.sht.po;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class AddrsExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public AddrsExample() {
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

        public Criteria andMasterIsNull() {
            addCriterion("MASTER is null");
            return (Criteria) this;
        }

        public Criteria andMasterIsNotNull() {
            addCriterion("MASTER is not null");
            return (Criteria) this;
        }

        public Criteria andMasterEqualTo(Object value) {
            addCriterion("MASTER =", value, "master");
            return (Criteria) this;
        }

        public Criteria andMasterNotEqualTo(Object value) {
            addCriterion("MASTER <>", value, "master");
            return (Criteria) this;
        }

        public Criteria andMasterGreaterThan(Object value) {
            addCriterion("MASTER >", value, "master");
            return (Criteria) this;
        }

        public Criteria andMasterGreaterThanOrEqualTo(Object value) {
            addCriterion("MASTER >=", value, "master");
            return (Criteria) this;
        }

        public Criteria andMasterLessThan(Object value) {
            addCriterion("MASTER <", value, "master");
            return (Criteria) this;
        }

        public Criteria andMasterLessThanOrEqualTo(Object value) {
            addCriterion("MASTER <=", value, "master");
            return (Criteria) this;
        }

        public Criteria andMasterIn(List<Object> values) {
            addCriterion("MASTER in", values, "master");
            return (Criteria) this;
        }

        public Criteria andMasterNotIn(List<Object> values) {
            addCriterion("MASTER not in", values, "master");
            return (Criteria) this;
        }

        public Criteria andMasterBetween(Object value1, Object value2) {
            addCriterion("MASTER between", value1, value2, "master");
            return (Criteria) this;
        }

        public Criteria andMasterNotBetween(Object value1, Object value2) {
            addCriterion("MASTER not between", value1, value2, "master");
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

        public Criteria andRegionEqualTo(BigDecimal value) {
            addCriterion("REGION =", value, "region");
            return (Criteria) this;
        }

        public Criteria andRegionNotEqualTo(BigDecimal value) {
            addCriterion("REGION <>", value, "region");
            return (Criteria) this;
        }

        public Criteria andRegionGreaterThan(BigDecimal value) {
            addCriterion("REGION >", value, "region");
            return (Criteria) this;
        }

        public Criteria andRegionGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("REGION >=", value, "region");
            return (Criteria) this;
        }

        public Criteria andRegionLessThan(BigDecimal value) {
            addCriterion("REGION <", value, "region");
            return (Criteria) this;
        }

        public Criteria andRegionLessThanOrEqualTo(BigDecimal value) {
            addCriterion("REGION <=", value, "region");
            return (Criteria) this;
        }

        public Criteria andRegionIn(List<BigDecimal> values) {
            addCriterion("REGION in", values, "region");
            return (Criteria) this;
        }

        public Criteria andRegionNotIn(List<BigDecimal> values) {
            addCriterion("REGION not in", values, "region");
            return (Criteria) this;
        }

        public Criteria andRegionBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("REGION between", value1, value2, "region");
            return (Criteria) this;
        }

        public Criteria andRegionNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("REGION not between", value1, value2, "region");
            return (Criteria) this;
        }

        public Criteria andDetailIsNull() {
            addCriterion("DETAIL is null");
            return (Criteria) this;
        }

        public Criteria andDetailIsNotNull() {
            addCriterion("DETAIL is not null");
            return (Criteria) this;
        }

        public Criteria andDetailEqualTo(Object value) {
            addCriterion("DETAIL =", value, "detail");
            return (Criteria) this;
        }

        public Criteria andDetailNotEqualTo(Object value) {
            addCriterion("DETAIL <>", value, "detail");
            return (Criteria) this;
        }

        public Criteria andDetailGreaterThan(Object value) {
            addCriterion("DETAIL >", value, "detail");
            return (Criteria) this;
        }

        public Criteria andDetailGreaterThanOrEqualTo(Object value) {
            addCriterion("DETAIL >=", value, "detail");
            return (Criteria) this;
        }

        public Criteria andDetailLessThan(Object value) {
            addCriterion("DETAIL <", value, "detail");
            return (Criteria) this;
        }

        public Criteria andDetailLessThanOrEqualTo(Object value) {
            addCriterion("DETAIL <=", value, "detail");
            return (Criteria) this;
        }

        public Criteria andDetailIn(List<Object> values) {
            addCriterion("DETAIL in", values, "detail");
            return (Criteria) this;
        }

        public Criteria andDetailNotIn(List<Object> values) {
            addCriterion("DETAIL not in", values, "detail");
            return (Criteria) this;
        }

        public Criteria andDetailBetween(Object value1, Object value2) {
            addCriterion("DETAIL between", value1, value2, "detail");
            return (Criteria) this;
        }

        public Criteria andDetailNotBetween(Object value1, Object value2) {
            addCriterion("DETAIL not between", value1, value2, "detail");
            return (Criteria) this;
        }

        public Criteria andPohneIsNull() {
            addCriterion("POHNE is null");
            return (Criteria) this;
        }

        public Criteria andPohneIsNotNull() {
            addCriterion("POHNE is not null");
            return (Criteria) this;
        }

        public Criteria andPohneEqualTo(Object value) {
            addCriterion("POHNE =", value, "pohne");
            return (Criteria) this;
        }

        public Criteria andPohneNotEqualTo(Object value) {
            addCriterion("POHNE <>", value, "pohne");
            return (Criteria) this;
        }

        public Criteria andPohneGreaterThan(Object value) {
            addCriterion("POHNE >", value, "pohne");
            return (Criteria) this;
        }

        public Criteria andPohneGreaterThanOrEqualTo(Object value) {
            addCriterion("POHNE >=", value, "pohne");
            return (Criteria) this;
        }

        public Criteria andPohneLessThan(Object value) {
            addCriterion("POHNE <", value, "pohne");
            return (Criteria) this;
        }

        public Criteria andPohneLessThanOrEqualTo(Object value) {
            addCriterion("POHNE <=", value, "pohne");
            return (Criteria) this;
        }

        public Criteria andPohneIn(List<Object> values) {
            addCriterion("POHNE in", values, "pohne");
            return (Criteria) this;
        }

        public Criteria andPohneNotIn(List<Object> values) {
            addCriterion("POHNE not in", values, "pohne");
            return (Criteria) this;
        }

        public Criteria andPohneBetween(Object value1, Object value2) {
            addCriterion("POHNE between", value1, value2, "pohne");
            return (Criteria) this;
        }

        public Criteria andPohneNotBetween(Object value1, Object value2) {
            addCriterion("POHNE not between", value1, value2, "pohne");
            return (Criteria) this;
        }

        public Criteria andRealnameIsNull() {
            addCriterion("REALNAME is null");
            return (Criteria) this;
        }

        public Criteria andRealnameIsNotNull() {
            addCriterion("REALNAME is not null");
            return (Criteria) this;
        }

        public Criteria andRealnameEqualTo(Object value) {
            addCriterion("REALNAME =", value, "realname");
            return (Criteria) this;
        }

        public Criteria andRealnameNotEqualTo(Object value) {
            addCriterion("REALNAME <>", value, "realname");
            return (Criteria) this;
        }

        public Criteria andRealnameGreaterThan(Object value) {
            addCriterion("REALNAME >", value, "realname");
            return (Criteria) this;
        }

        public Criteria andRealnameGreaterThanOrEqualTo(Object value) {
            addCriterion("REALNAME >=", value, "realname");
            return (Criteria) this;
        }

        public Criteria andRealnameLessThan(Object value) {
            addCriterion("REALNAME <", value, "realname");
            return (Criteria) this;
        }

        public Criteria andRealnameLessThanOrEqualTo(Object value) {
            addCriterion("REALNAME <=", value, "realname");
            return (Criteria) this;
        }

        public Criteria andRealnameIn(List<Object> values) {
            addCriterion("REALNAME in", values, "realname");
            return (Criteria) this;
        }

        public Criteria andRealnameNotIn(List<Object> values) {
            addCriterion("REALNAME not in", values, "realname");
            return (Criteria) this;
        }

        public Criteria andRealnameBetween(Object value1, Object value2) {
            addCriterion("REALNAME between", value1, value2, "realname");
            return (Criteria) this;
        }

        public Criteria andRealnameNotBetween(Object value1, Object value2) {
            addCriterion("REALNAME not between", value1, value2, "realname");
            return (Criteria) this;
        }

        public Criteria andIsdefaultIsNull() {
            addCriterion("ISDEFAULT is null");
            return (Criteria) this;
        }

        public Criteria andIsdefaultIsNotNull() {
            addCriterion("ISDEFAULT is not null");
            return (Criteria) this;
        }

        public Criteria andIsdefaultEqualTo(Short value) {
            addCriterion("ISDEFAULT =", value, "isdefault");
            return (Criteria) this;
        }

        public Criteria andIsdefaultNotEqualTo(Short value) {
            addCriterion("ISDEFAULT <>", value, "isdefault");
            return (Criteria) this;
        }

        public Criteria andIsdefaultGreaterThan(Short value) {
            addCriterion("ISDEFAULT >", value, "isdefault");
            return (Criteria) this;
        }

        public Criteria andIsdefaultGreaterThanOrEqualTo(Short value) {
            addCriterion("ISDEFAULT >=", value, "isdefault");
            return (Criteria) this;
        }

        public Criteria andIsdefaultLessThan(Short value) {
            addCriterion("ISDEFAULT <", value, "isdefault");
            return (Criteria) this;
        }

        public Criteria andIsdefaultLessThanOrEqualTo(Short value) {
            addCriterion("ISDEFAULT <=", value, "isdefault");
            return (Criteria) this;
        }

        public Criteria andIsdefaultIn(List<Short> values) {
            addCriterion("ISDEFAULT in", values, "isdefault");
            return (Criteria) this;
        }

        public Criteria andIsdefaultNotIn(List<Short> values) {
            addCriterion("ISDEFAULT not in", values, "isdefault");
            return (Criteria) this;
        }

        public Criteria andIsdefaultBetween(Short value1, Short value2) {
            addCriterion("ISDEFAULT between", value1, value2, "isdefault");
            return (Criteria) this;
        }

        public Criteria andIsdefaultNotBetween(Short value1, Short value2) {
            addCriterion("ISDEFAULT not between", value1, value2, "isdefault");
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

        public Criteria andPostcodeLike(String value) {
            addCriterion("POSTCODE like", value, "postcode");
            return (Criteria) this;
        }

        public Criteria andPostcodeNotLike(String value) {
            addCriterion("POSTCODE not like", value, "postcode");
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