package com.sht.po;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UsersLoginLogExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public UsersLoginLogExample() {
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

        public Criteria andLoginUserIsNull() {
            addCriterion("LOGIN_USER is null");
            return (Criteria) this;
        }

        public Criteria andLoginUserIsNotNull() {
            addCriterion("LOGIN_USER is not null");
            return (Criteria) this;
        }

        public Criteria andLoginUserEqualTo(Object value) {
            addCriterion("LOGIN_USER =", value, "loginUser");
            return (Criteria) this;
        }

        public Criteria andLoginUserNotEqualTo(Object value) {
            addCriterion("LOGIN_USER <>", value, "loginUser");
            return (Criteria) this;
        }

        public Criteria andLoginUserGreaterThan(Object value) {
            addCriterion("LOGIN_USER >", value, "loginUser");
            return (Criteria) this;
        }

        public Criteria andLoginUserGreaterThanOrEqualTo(Object value) {
            addCriterion("LOGIN_USER >=", value, "loginUser");
            return (Criteria) this;
        }

        public Criteria andLoginUserLessThan(Object value) {
            addCriterion("LOGIN_USER <", value, "loginUser");
            return (Criteria) this;
        }

        public Criteria andLoginUserLessThanOrEqualTo(Object value) {
            addCriterion("LOGIN_USER <=", value, "loginUser");
            return (Criteria) this;
        }

        public Criteria andLoginUserIn(List<Object> values) {
            addCriterion("LOGIN_USER in", values, "loginUser");
            return (Criteria) this;
        }

        public Criteria andLoginUserNotIn(List<Object> values) {
            addCriterion("LOGIN_USER not in", values, "loginUser");
            return (Criteria) this;
        }

        public Criteria andLoginUserBetween(Object value1, Object value2) {
            addCriterion("LOGIN_USER between", value1, value2, "loginUser");
            return (Criteria) this;
        }

        public Criteria andLoginUserNotBetween(Object value1, Object value2) {
            addCriterion("LOGIN_USER not between", value1, value2, "loginUser");
            return (Criteria) this;
        }

        public Criteria andIpIsNull() {
            addCriterion("IP is null");
            return (Criteria) this;
        }

        public Criteria andIpIsNotNull() {
            addCriterion("IP is not null");
            return (Criteria) this;
        }

        public Criteria andIpEqualTo(Object value) {
            addCriterion("IP =", value, "ip");
            return (Criteria) this;
        }

        public Criteria andIpNotEqualTo(Object value) {
            addCriterion("IP <>", value, "ip");
            return (Criteria) this;
        }

        public Criteria andIpGreaterThan(Object value) {
            addCriterion("IP >", value, "ip");
            return (Criteria) this;
        }

        public Criteria andIpGreaterThanOrEqualTo(Object value) {
            addCriterion("IP >=", value, "ip");
            return (Criteria) this;
        }

        public Criteria andIpLessThan(Object value) {
            addCriterion("IP <", value, "ip");
            return (Criteria) this;
        }

        public Criteria andIpLessThanOrEqualTo(Object value) {
            addCriterion("IP <=", value, "ip");
            return (Criteria) this;
        }

        public Criteria andIpIn(List<Object> values) {
            addCriterion("IP in", values, "ip");
            return (Criteria) this;
        }

        public Criteria andIpNotIn(List<Object> values) {
            addCriterion("IP not in", values, "ip");
            return (Criteria) this;
        }

        public Criteria andIpBetween(Object value1, Object value2) {
            addCriterion("IP between", value1, value2, "ip");
            return (Criteria) this;
        }

        public Criteria andIpNotBetween(Object value1, Object value2) {
            addCriterion("IP not between", value1, value2, "ip");
            return (Criteria) this;
        }

        public Criteria andSystemIsNull() {
            addCriterion("SYSTEM is null");
            return (Criteria) this;
        }

        public Criteria andSystemIsNotNull() {
            addCriterion("SYSTEM is not null");
            return (Criteria) this;
        }

        public Criteria andSystemEqualTo(Object value) {
            addCriterion("SYSTEM =", value, "system");
            return (Criteria) this;
        }

        public Criteria andSystemNotEqualTo(Object value) {
            addCriterion("SYSTEM <>", value, "system");
            return (Criteria) this;
        }

        public Criteria andSystemGreaterThan(Object value) {
            addCriterion("SYSTEM >", value, "system");
            return (Criteria) this;
        }

        public Criteria andSystemGreaterThanOrEqualTo(Object value) {
            addCriterion("SYSTEM >=", value, "system");
            return (Criteria) this;
        }

        public Criteria andSystemLessThan(Object value) {
            addCriterion("SYSTEM <", value, "system");
            return (Criteria) this;
        }

        public Criteria andSystemLessThanOrEqualTo(Object value) {
            addCriterion("SYSTEM <=", value, "system");
            return (Criteria) this;
        }

        public Criteria andSystemIn(List<Object> values) {
            addCriterion("SYSTEM in", values, "system");
            return (Criteria) this;
        }

        public Criteria andSystemNotIn(List<Object> values) {
            addCriterion("SYSTEM not in", values, "system");
            return (Criteria) this;
        }

        public Criteria andSystemBetween(Object value1, Object value2) {
            addCriterion("SYSTEM between", value1, value2, "system");
            return (Criteria) this;
        }

        public Criteria andSystemNotBetween(Object value1, Object value2) {
            addCriterion("SYSTEM not between", value1, value2, "system");
            return (Criteria) this;
        }

        public Criteria andDpiIsNull() {
            addCriterion("DPI is null");
            return (Criteria) this;
        }

        public Criteria andDpiIsNotNull() {
            addCriterion("DPI is not null");
            return (Criteria) this;
        }

        public Criteria andDpiEqualTo(Object value) {
            addCriterion("DPI =", value, "dpi");
            return (Criteria) this;
        }

        public Criteria andDpiNotEqualTo(Object value) {
            addCriterion("DPI <>", value, "dpi");
            return (Criteria) this;
        }

        public Criteria andDpiGreaterThan(Object value) {
            addCriterion("DPI >", value, "dpi");
            return (Criteria) this;
        }

        public Criteria andDpiGreaterThanOrEqualTo(Object value) {
            addCriterion("DPI >=", value, "dpi");
            return (Criteria) this;
        }

        public Criteria andDpiLessThan(Object value) {
            addCriterion("DPI <", value, "dpi");
            return (Criteria) this;
        }

        public Criteria andDpiLessThanOrEqualTo(Object value) {
            addCriterion("DPI <=", value, "dpi");
            return (Criteria) this;
        }

        public Criteria andDpiIn(List<Object> values) {
            addCriterion("DPI in", values, "dpi");
            return (Criteria) this;
        }

        public Criteria andDpiNotIn(List<Object> values) {
            addCriterion("DPI not in", values, "dpi");
            return (Criteria) this;
        }

        public Criteria andDpiBetween(Object value1, Object value2) {
            addCriterion("DPI between", value1, value2, "dpi");
            return (Criteria) this;
        }

        public Criteria andDpiNotBetween(Object value1, Object value2) {
            addCriterion("DPI not between", value1, value2, "dpi");
            return (Criteria) this;
        }

        public Criteria andBrowserIsNull() {
            addCriterion("BROWSER is null");
            return (Criteria) this;
        }

        public Criteria andBrowserIsNotNull() {
            addCriterion("BROWSER is not null");
            return (Criteria) this;
        }

        public Criteria andBrowserEqualTo(Object value) {
            addCriterion("BROWSER =", value, "browser");
            return (Criteria) this;
        }

        public Criteria andBrowserNotEqualTo(Object value) {
            addCriterion("BROWSER <>", value, "browser");
            return (Criteria) this;
        }

        public Criteria andBrowserGreaterThan(Object value) {
            addCriterion("BROWSER >", value, "browser");
            return (Criteria) this;
        }

        public Criteria andBrowserGreaterThanOrEqualTo(Object value) {
            addCriterion("BROWSER >=", value, "browser");
            return (Criteria) this;
        }

        public Criteria andBrowserLessThan(Object value) {
            addCriterion("BROWSER <", value, "browser");
            return (Criteria) this;
        }

        public Criteria andBrowserLessThanOrEqualTo(Object value) {
            addCriterion("BROWSER <=", value, "browser");
            return (Criteria) this;
        }

        public Criteria andBrowserIn(List<Object> values) {
            addCriterion("BROWSER in", values, "browser");
            return (Criteria) this;
        }

        public Criteria andBrowserNotIn(List<Object> values) {
            addCriterion("BROWSER not in", values, "browser");
            return (Criteria) this;
        }

        public Criteria andBrowserBetween(Object value1, Object value2) {
            addCriterion("BROWSER between", value1, value2, "browser");
            return (Criteria) this;
        }

        public Criteria andBrowserNotBetween(Object value1, Object value2) {
            addCriterion("BROWSER not between", value1, value2, "browser");
            return (Criteria) this;
        }

        public Criteria andCountryIsNull() {
            addCriterion("COUNTRY is null");
            return (Criteria) this;
        }

        public Criteria andCountryIsNotNull() {
            addCriterion("COUNTRY is not null");
            return (Criteria) this;
        }

        public Criteria andCountryEqualTo(Object value) {
            addCriterion("COUNTRY =", value, "country");
            return (Criteria) this;
        }

        public Criteria andCountryNotEqualTo(Object value) {
            addCriterion("COUNTRY <>", value, "country");
            return (Criteria) this;
        }

        public Criteria andCountryGreaterThan(Object value) {
            addCriterion("COUNTRY >", value, "country");
            return (Criteria) this;
        }

        public Criteria andCountryGreaterThanOrEqualTo(Object value) {
            addCriterion("COUNTRY >=", value, "country");
            return (Criteria) this;
        }

        public Criteria andCountryLessThan(Object value) {
            addCriterion("COUNTRY <", value, "country");
            return (Criteria) this;
        }

        public Criteria andCountryLessThanOrEqualTo(Object value) {
            addCriterion("COUNTRY <=", value, "country");
            return (Criteria) this;
        }

        public Criteria andCountryIn(List<Object> values) {
            addCriterion("COUNTRY in", values, "country");
            return (Criteria) this;
        }

        public Criteria andCountryNotIn(List<Object> values) {
            addCriterion("COUNTRY not in", values, "country");
            return (Criteria) this;
        }

        public Criteria andCountryBetween(Object value1, Object value2) {
            addCriterion("COUNTRY between", value1, value2, "country");
            return (Criteria) this;
        }

        public Criteria andCountryNotBetween(Object value1, Object value2) {
            addCriterion("COUNTRY not between", value1, value2, "country");
            return (Criteria) this;
        }

        public Criteria andProvinceIsNull() {
            addCriterion("PROVINCE is null");
            return (Criteria) this;
        }

        public Criteria andProvinceIsNotNull() {
            addCriterion("PROVINCE is not null");
            return (Criteria) this;
        }

        public Criteria andProvinceEqualTo(Object value) {
            addCriterion("PROVINCE =", value, "province");
            return (Criteria) this;
        }

        public Criteria andProvinceNotEqualTo(Object value) {
            addCriterion("PROVINCE <>", value, "province");
            return (Criteria) this;
        }

        public Criteria andProvinceGreaterThan(Object value) {
            addCriterion("PROVINCE >", value, "province");
            return (Criteria) this;
        }

        public Criteria andProvinceGreaterThanOrEqualTo(Object value) {
            addCriterion("PROVINCE >=", value, "province");
            return (Criteria) this;
        }

        public Criteria andProvinceLessThan(Object value) {
            addCriterion("PROVINCE <", value, "province");
            return (Criteria) this;
        }

        public Criteria andProvinceLessThanOrEqualTo(Object value) {
            addCriterion("PROVINCE <=", value, "province");
            return (Criteria) this;
        }

        public Criteria andProvinceIn(List<Object> values) {
            addCriterion("PROVINCE in", values, "province");
            return (Criteria) this;
        }

        public Criteria andProvinceNotIn(List<Object> values) {
            addCriterion("PROVINCE not in", values, "province");
            return (Criteria) this;
        }

        public Criteria andProvinceBetween(Object value1, Object value2) {
            addCriterion("PROVINCE between", value1, value2, "province");
            return (Criteria) this;
        }

        public Criteria andProvinceNotBetween(Object value1, Object value2) {
            addCriterion("PROVINCE not between", value1, value2, "province");
            return (Criteria) this;
        }

        public Criteria andCityIsNull() {
            addCriterion("CITY is null");
            return (Criteria) this;
        }

        public Criteria andCityIsNotNull() {
            addCriterion("CITY is not null");
            return (Criteria) this;
        }

        public Criteria andCityEqualTo(Object value) {
            addCriterion("CITY =", value, "city");
            return (Criteria) this;
        }

        public Criteria andCityNotEqualTo(Object value) {
            addCriterion("CITY <>", value, "city");
            return (Criteria) this;
        }

        public Criteria andCityGreaterThan(Object value) {
            addCriterion("CITY >", value, "city");
            return (Criteria) this;
        }

        public Criteria andCityGreaterThanOrEqualTo(Object value) {
            addCriterion("CITY >=", value, "city");
            return (Criteria) this;
        }

        public Criteria andCityLessThan(Object value) {
            addCriterion("CITY <", value, "city");
            return (Criteria) this;
        }

        public Criteria andCityLessThanOrEqualTo(Object value) {
            addCriterion("CITY <=", value, "city");
            return (Criteria) this;
        }

        public Criteria andCityIn(List<Object> values) {
            addCriterion("CITY in", values, "city");
            return (Criteria) this;
        }

        public Criteria andCityNotIn(List<Object> values) {
            addCriterion("CITY not in", values, "city");
            return (Criteria) this;
        }

        public Criteria andCityBetween(Object value1, Object value2) {
            addCriterion("CITY between", value1, value2, "city");
            return (Criteria) this;
        }

        public Criteria andCityNotBetween(Object value1, Object value2) {
            addCriterion("CITY not between", value1, value2, "city");
            return (Criteria) this;
        }

        public Criteria andTimeIsNull() {
            addCriterion("TIME is null");
            return (Criteria) this;
        }

        public Criteria andTimeIsNotNull() {
            addCriterion("TIME is not null");
            return (Criteria) this;
        }

        public Criteria andTimeEqualTo(Date value) {
            addCriterion("TIME =", value, "time");
            return (Criteria) this;
        }

        public Criteria andTimeNotEqualTo(Date value) {
            addCriterion("TIME <>", value, "time");
            return (Criteria) this;
        }

        public Criteria andTimeGreaterThan(Date value) {
            addCriterion("TIME >", value, "time");
            return (Criteria) this;
        }

        public Criteria andTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("TIME >=", value, "time");
            return (Criteria) this;
        }

        public Criteria andTimeLessThan(Date value) {
            addCriterion("TIME <", value, "time");
            return (Criteria) this;
        }

        public Criteria andTimeLessThanOrEqualTo(Date value) {
            addCriterion("TIME <=", value, "time");
            return (Criteria) this;
        }

        public Criteria andTimeIn(List<Date> values) {
            addCriterion("TIME in", values, "time");
            return (Criteria) this;
        }

        public Criteria andTimeNotIn(List<Date> values) {
            addCriterion("TIME not in", values, "time");
            return (Criteria) this;
        }

        public Criteria andTimeBetween(Date value1, Date value2) {
            addCriterion("TIME between", value1, value2, "time");
            return (Criteria) this;
        }

        public Criteria andTimeNotBetween(Date value1, Date value2) {
            addCriterion("TIME not between", value1, value2, "time");
            return (Criteria) this;
        }

        public Criteria andResultIsNull() {
            addCriterion("RESULT is null");
            return (Criteria) this;
        }

        public Criteria andResultIsNotNull() {
            addCriterion("RESULT is not null");
            return (Criteria) this;
        }

        public Criteria andResultEqualTo(Short value) {
            addCriterion("RESULT =", value, "result");
            return (Criteria) this;
        }

        public Criteria andResultNotEqualTo(Short value) {
            addCriterion("RESULT <>", value, "result");
            return (Criteria) this;
        }

        public Criteria andResultGreaterThan(Short value) {
            addCriterion("RESULT >", value, "result");
            return (Criteria) this;
        }

        public Criteria andResultGreaterThanOrEqualTo(Short value) {
            addCriterion("RESULT >=", value, "result");
            return (Criteria) this;
        }

        public Criteria andResultLessThan(Short value) {
            addCriterion("RESULT <", value, "result");
            return (Criteria) this;
        }

        public Criteria andResultLessThanOrEqualTo(Short value) {
            addCriterion("RESULT <=", value, "result");
            return (Criteria) this;
        }

        public Criteria andResultIn(List<Short> values) {
            addCriterion("RESULT in", values, "result");
            return (Criteria) this;
        }

        public Criteria andResultNotIn(List<Short> values) {
            addCriterion("RESULT not in", values, "result");
            return (Criteria) this;
        }

        public Criteria andResultBetween(Short value1, Short value2) {
            addCriterion("RESULT between", value1, value2, "result");
            return (Criteria) this;
        }

        public Criteria andResultNotBetween(Short value1, Short value2) {
            addCriterion("RESULT not between", value1, value2, "result");
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