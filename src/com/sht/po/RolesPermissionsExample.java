package com.sht.po;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class RolesPermissionsExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public RolesPermissionsExample() {
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

        public Criteria andRoleIsNull() {
            addCriterion("ROLE is null");
            return (Criteria) this;
        }

        public Criteria andRoleIsNotNull() {
            addCriterion("ROLE is not null");
            return (Criteria) this;
        }

        public Criteria andRoleEqualTo(Object value) {
            addCriterion("ROLE =", value, "role");
            return (Criteria) this;
        }

        public Criteria andRoleNotEqualTo(Object value) {
            addCriterion("ROLE <>", value, "role");
            return (Criteria) this;
        }

        public Criteria andRoleGreaterThan(Object value) {
            addCriterion("ROLE >", value, "role");
            return (Criteria) this;
        }

        public Criteria andRoleGreaterThanOrEqualTo(Object value) {
            addCriterion("ROLE >=", value, "role");
            return (Criteria) this;
        }

        public Criteria andRoleLessThan(Object value) {
            addCriterion("ROLE <", value, "role");
            return (Criteria) this;
        }

        public Criteria andRoleLessThanOrEqualTo(Object value) {
            addCriterion("ROLE <=", value, "role");
            return (Criteria) this;
        }

        public Criteria andRoleIn(List<Object> values) {
            addCriterion("ROLE in", values, "role");
            return (Criteria) this;
        }

        public Criteria andRoleNotIn(List<Object> values) {
            addCriterion("ROLE not in", values, "role");
            return (Criteria) this;
        }

        public Criteria andRoleBetween(Object value1, Object value2) {
            addCriterion("ROLE between", value1, value2, "role");
            return (Criteria) this;
        }

        public Criteria andRoleNotBetween(Object value1, Object value2) {
            addCriterion("ROLE not between", value1, value2, "role");
            return (Criteria) this;
        }

        public Criteria andPermissionIsNull() {
            addCriterion("PERMISSION is null");
            return (Criteria) this;
        }

        public Criteria andPermissionIsNotNull() {
            addCriterion("PERMISSION is not null");
            return (Criteria) this;
        }

        public Criteria andPermissionEqualTo(Object value) {
            addCriterion("PERMISSION =", value, "permission");
            return (Criteria) this;
        }

        public Criteria andPermissionNotEqualTo(Object value) {
            addCriterion("PERMISSION <>", value, "permission");
            return (Criteria) this;
        }

        public Criteria andPermissionGreaterThan(Object value) {
            addCriterion("PERMISSION >", value, "permission");
            return (Criteria) this;
        }

        public Criteria andPermissionGreaterThanOrEqualTo(Object value) {
            addCriterion("PERMISSION >=", value, "permission");
            return (Criteria) this;
        }

        public Criteria andPermissionLessThan(Object value) {
            addCriterion("PERMISSION <", value, "permission");
            return (Criteria) this;
        }

        public Criteria andPermissionLessThanOrEqualTo(Object value) {
            addCriterion("PERMISSION <=", value, "permission");
            return (Criteria) this;
        }

        public Criteria andPermissionIn(List<Object> values) {
            addCriterion("PERMISSION in", values, "permission");
            return (Criteria) this;
        }

        public Criteria andPermissionNotIn(List<Object> values) {
            addCriterion("PERMISSION not in", values, "permission");
            return (Criteria) this;
        }

        public Criteria andPermissionBetween(Object value1, Object value2) {
            addCriterion("PERMISSION between", value1, value2, "permission");
            return (Criteria) this;
        }

        public Criteria andPermissionNotBetween(Object value1, Object value2) {
            addCriterion("PERMISSION not between", value1, value2, "permission");
            return (Criteria) this;
        }

        public Criteria andGranttimeIsNull() {
            addCriterion("GRANTTIME is null");
            return (Criteria) this;
        }

        public Criteria andGranttimeIsNotNull() {
            addCriterion("GRANTTIME is not null");
            return (Criteria) this;
        }

        public Criteria andGranttimeEqualTo(Date value) {
            addCriterion("GRANTTIME =", value, "granttime");
            return (Criteria) this;
        }

        public Criteria andGranttimeNotEqualTo(Date value) {
            addCriterion("GRANTTIME <>", value, "granttime");
            return (Criteria) this;
        }

        public Criteria andGranttimeGreaterThan(Date value) {
            addCriterion("GRANTTIME >", value, "granttime");
            return (Criteria) this;
        }

        public Criteria andGranttimeGreaterThanOrEqualTo(Date value) {
            addCriterion("GRANTTIME >=", value, "granttime");
            return (Criteria) this;
        }

        public Criteria andGranttimeLessThan(Date value) {
            addCriterion("GRANTTIME <", value, "granttime");
            return (Criteria) this;
        }

        public Criteria andGranttimeLessThanOrEqualTo(Date value) {
            addCriterion("GRANTTIME <=", value, "granttime");
            return (Criteria) this;
        }

        public Criteria andGranttimeIn(List<Date> values) {
            addCriterion("GRANTTIME in", values, "granttime");
            return (Criteria) this;
        }

        public Criteria andGranttimeNotIn(List<Date> values) {
            addCriterion("GRANTTIME not in", values, "granttime");
            return (Criteria) this;
        }

        public Criteria andGranttimeBetween(Date value1, Date value2) {
            addCriterion("GRANTTIME between", value1, value2, "granttime");
            return (Criteria) this;
        }

        public Criteria andGranttimeNotBetween(Date value1, Date value2) {
            addCriterion("GRANTTIME not between", value1, value2, "granttime");
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