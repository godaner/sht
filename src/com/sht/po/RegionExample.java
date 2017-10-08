package com.sht.po;

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

        public Criteria andIdIsNull() {
            addCriterion("ID is null");
            return (Criteria) this;
        }

        public Criteria andIdIsNotNull() {
            addCriterion("ID is not null");
            return (Criteria) this;
        }


        public Criteria andIdEqualTo(Integer value) {

            addCriterion("ID =", value, "id");
            return (Criteria) this;
        }


        public Criteria andIdNotEqualTo(Integer value) {

            addCriterion("ID <>", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThan(Integer value) {

            addCriterion("ID >", value, "id");
            return (Criteria) this;
        }


        public Criteria andIdGreaterThanOrEqualTo(Integer value) {

            addCriterion("ID >=", value, "id");
            return (Criteria) this;
        }


        public Criteria andIdLessThan(Integer value) {

            addCriterion("ID <", value, "id");
            return (Criteria) this;
        }


        public Criteria andIdLessThanOrEqualTo(Integer value) {

            addCriterion("ID <=", value, "id");
            return (Criteria) this;
        }


        public Criteria andIdIn(List<Integer> values) {

            addCriterion("ID in", values, "id");
            return (Criteria) this;
        }


        public Criteria andIdNotIn(List<Integer> values) {

            addCriterion("ID not in", values, "id");
            return (Criteria) this;
        }


        public Criteria andIdBetween(Integer value1, Integer value2) {

            addCriterion("ID between", value1, value2, "id");
            return (Criteria) this;
        }


        public Criteria andIdNotBetween(Integer value1, Integer value2) {

            addCriterion("ID not between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andCodeIsNull() {
            addCriterion("CODE is null");
            return (Criteria) this;
        }

        public Criteria andCodeIsNotNull() {
            addCriterion("CODE is not null");
            return (Criteria) this;
        }

        public Criteria andCodeEqualTo(String value) {
            addCriterion("CODE =", value, "code");
            return (Criteria) this;
        }

        public Criteria andCodeNotEqualTo(String value) {
            addCriterion("CODE <>", value, "code");
            return (Criteria) this;
        }

        public Criteria andCodeGreaterThan(String value) {
            addCriterion("CODE >", value, "code");
            return (Criteria) this;
        }

        public Criteria andCodeGreaterThanOrEqualTo(String value) {
            addCriterion("CODE >=", value, "code");
            return (Criteria) this;
        }

        public Criteria andCodeLessThan(String value) {
            addCriterion("CODE <", value, "code");
            return (Criteria) this;
        }

        public Criteria andCodeLessThanOrEqualTo(String value) {
            addCriterion("CODE <=", value, "code");
            return (Criteria) this;
        }

        public Criteria andCodeLike(String value) {
            addCriterion("CODE like", value, "code");
            return (Criteria) this;
        }

        public Criteria andCodeNotLike(String value) {
            addCriterion("CODE not like", value, "code");
            return (Criteria) this;
        }

        public Criteria andCodeIn(List<String> values) {
            addCriterion("CODE in", values, "code");
            return (Criteria) this;
        }

        public Criteria andCodeNotIn(List<String> values) {
            addCriterion("CODE not in", values, "code");
            return (Criteria) this;
        }

        public Criteria andCodeBetween(String value1, String value2) {
            addCriterion("CODE between", value1, value2, "code");
            return (Criteria) this;
        }

        public Criteria andCodeNotBetween(String value1, String value2) {
            addCriterion("CODE not between", value1, value2, "code");
            return (Criteria) this;
        }

        public Criteria andNameIsNull() {
            addCriterion("NAME is null");
            return (Criteria) this;
        }

        public Criteria andNameIsNotNull() {
            addCriterion("NAME is not null");
            return (Criteria) this;
        }

        public Criteria andNameEqualTo(String value) {
            addCriterion("NAME =", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameNotEqualTo(String value) {
            addCriterion("NAME <>", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameGreaterThan(String value) {
            addCriterion("NAME >", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameGreaterThanOrEqualTo(String value) {
            addCriterion("NAME >=", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameLessThan(String value) {
            addCriterion("NAME <", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameLessThanOrEqualTo(String value) {
            addCriterion("NAME <=", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameLike(String value) {
            addCriterion("NAME like", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameNotLike(String value) {
            addCriterion("NAME not like", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameIn(List<String> values) {
            addCriterion("NAME in", values, "name");
            return (Criteria) this;
        }

        public Criteria andNameNotIn(List<String> values) {
            addCriterion("NAME not in", values, "name");
            return (Criteria) this;
        }

        public Criteria andNameBetween(String value1, String value2) {
            addCriterion("NAME between", value1, value2, "name");
            return (Criteria) this;
        }

        public Criteria andNameNotBetween(String value1, String value2) {
            addCriterion("NAME not between", value1, value2, "name");
            return (Criteria) this;
        }

        public Criteria andPidIsNull() {
            addCriterion("PID is null");
            return (Criteria) this;
        }

        public Criteria andPidIsNotNull() {
            addCriterion("PID is not null");
            return (Criteria) this;
        }

        public Criteria andPidEqualTo(Integer value) {

            addCriterion("PID =", value, "pid");
            return (Criteria) this;
        }


        public Criteria andPidNotEqualTo(Integer value) {

            addCriterion("PID <>", value, "pid");
            return (Criteria) this;
        }


        public Criteria andPidGreaterThan(Integer value) {

            addCriterion("PID >", value, "pid");
            return (Criteria) this;
        }

        public Criteria andPidGreaterThanOrEqualTo(Integer value) {

            addCriterion("PID >=", value, "pid");
            return (Criteria) this;
        }


        public Criteria andPidLessThan(Integer value) {

            addCriterion("PID <", value, "pid");
            return (Criteria) this;
        }


        public Criteria andPidLessThanOrEqualTo(Integer value) {

            addCriterion("PID <=", value, "pid");
            return (Criteria) this;
        }


        public Criteria andPidIn(List<Integer> values) {

            addCriterion("PID in", values, "pid");
            return (Criteria) this;
        }


        public Criteria andPidNotIn(List<Integer> values) {

            addCriterion("PID not in", values, "pid");
            return (Criteria) this;
        }


        public Criteria andPidBetween(Integer value1, Integer value2) {

            addCriterion("PID between", value1, value2, "pid");
            return (Criteria) this;
        }

        public Criteria andPidNotBetween(Integer value1, Integer value2) {

            addCriterion("PID not between", value1, value2, "pid");
            return (Criteria) this;
        }

        public Criteria andLeveIsNull() {
            addCriterion("LEVE is null");
            return (Criteria) this;
        }

        public Criteria andLeveIsNotNull() {
            addCriterion("LEVE is not null");
            return (Criteria) this;
        }


        public Criteria andLeveEqualTo(Integer value) {

            addCriterion("LEVE =", value, "leve");
            return (Criteria) this;
        }


        public Criteria andLeveNotEqualTo(Integer value) {

            addCriterion("LEVE <>", value, "leve");
            return (Criteria) this;
        }


        public Criteria andLeveGreaterThan(Integer value) {

            addCriterion("LEVE >", value, "leve");
            return (Criteria) this;
        }

        public Criteria andLeveGreaterThanOrEqualTo(Integer value) {

            addCriterion("LEVE >=", value, "leve");
            return (Criteria) this;
        }


        public Criteria andLeveLessThan(Integer value) {

            addCriterion("LEVE <", value, "leve");
            return (Criteria) this;
        }


        public Criteria andLeveLessThanOrEqualTo(Integer value) {

            addCriterion("LEVE <=", value, "leve");
            return (Criteria) this;
        }


        public Criteria andLeveIn(List<Integer> values) {

            addCriterion("LEVE in", values, "leve");
            return (Criteria) this;
        }

        public Criteria andLeveNotIn(List<Integer> values) {

            addCriterion("LEVE not in", values, "leve");
            return (Criteria) this;
        }


        public Criteria andLeveBetween(Integer value1, Integer value2) {

            addCriterion("LEVE between", value1, value2, "leve");
            return (Criteria) this;
        }


        public Criteria andLeveNotBetween(Integer value1, Integer value2) {

            addCriterion("LEVE not between", value1, value2, "leve");
            return (Criteria) this;
        }

        public Criteria andOrdeIsNull() {
            addCriterion("ORDE is null");
            return (Criteria) this;
        }

        public Criteria andOrdeIsNotNull() {
            addCriterion("ORDE is not null");
            return (Criteria) this;
        }


        public Criteria andOrdeEqualTo(Integer value) {

            addCriterion("ORDE =", value, "orde");
            return (Criteria) this;
        }


        public Criteria andOrdeNotEqualTo(Integer value) {

            addCriterion("ORDE <>", value, "orde");
            return (Criteria) this;
        }


        public Criteria andOrdeGreaterThan(Integer value) {

            addCriterion("ORDE >", value, "orde");
            return (Criteria) this;
        }


        public Criteria andOrdeGreaterThanOrEqualTo(Integer value) {

            addCriterion("ORDE >=", value, "orde");
            return (Criteria) this;
        }


        public Criteria andOrdeLessThan(Integer value) {

            addCriterion("ORDE <", value, "orde");
            return (Criteria) this;
        }

        public Criteria andOrdeLessThanOrEqualTo(Integer value) {

            addCriterion("ORDE <=", value, "orde");
            return (Criteria) this;
        }


        public Criteria andOrdeIn(List<Integer> values) {

            addCriterion("ORDE in", values, "orde");
            return (Criteria) this;
        }


        public Criteria andOrdeNotIn(List<Integer> values) {

            addCriterion("ORDE not in", values, "orde");
            return (Criteria) this;
        }


        public Criteria andOrdeBetween(Integer value1, Integer value2) {

            addCriterion("ORDE between", value1, value2, "orde");
            return (Criteria) this;
        }


        public Criteria andOrdeNotBetween(Integer value1, Integer value2) {

            addCriterion("ORDE not between", value1, value2, "orde");
            return (Criteria) this;
        }

        public Criteria andEnnameIsNull() {
            addCriterion("ENNAME is null");
            return (Criteria) this;
        }

        public Criteria andEnnameIsNotNull() {
            addCriterion("ENNAME is not null");
            return (Criteria) this;
        }

        public Criteria andEnnameEqualTo(String value) {
            addCriterion("ENNAME =", value, "enname");
            return (Criteria) this;
        }

        public Criteria andEnnameNotEqualTo(String value) {
            addCriterion("ENNAME <>", value, "enname");
            return (Criteria) this;
        }

        public Criteria andEnnameGreaterThan(String value) {
            addCriterion("ENNAME >", value, "enname");
            return (Criteria) this;
        }

        public Criteria andEnnameGreaterThanOrEqualTo(String value) {
            addCriterion("ENNAME >=", value, "enname");
            return (Criteria) this;
        }

        public Criteria andEnnameLessThan(String value) {
            addCriterion("ENNAME <", value, "enname");
            return (Criteria) this;
        }

        public Criteria andEnnameLessThanOrEqualTo(String value) {
            addCriterion("ENNAME <=", value, "enname");
            return (Criteria) this;
        }

        public Criteria andEnnameLike(String value) {
            addCriterion("ENNAME like", value, "enname");
            return (Criteria) this;
        }

        public Criteria andEnnameNotLike(String value) {
            addCriterion("ENNAME not like", value, "enname");
            return (Criteria) this;
        }

        public Criteria andEnnameIn(List<String> values) {
            addCriterion("ENNAME in", values, "enname");
            return (Criteria) this;
        }

        public Criteria andEnnameNotIn(List<String> values) {
            addCriterion("ENNAME not in", values, "enname");
            return (Criteria) this;
        }

        public Criteria andEnnameBetween(String value1, String value2) {
            addCriterion("ENNAME between", value1, value2, "enname");
            return (Criteria) this;
        }

        public Criteria andEnnameNotBetween(String value1, String value2) {
            addCriterion("ENNAME not between", value1, value2, "enname");
            return (Criteria) this;
        }

        public Criteria andEnshortnameIsNull() {
            addCriterion("ENSHORTNAME is null");
            return (Criteria) this;
        }

        public Criteria andEnshortnameIsNotNull() {
            addCriterion("ENSHORTNAME is not null");
            return (Criteria) this;
        }

        public Criteria andEnshortnameEqualTo(String value) {
            addCriterion("ENSHORTNAME =", value, "enshortname");
            return (Criteria) this;
        }

        public Criteria andEnshortnameNotEqualTo(String value) {
            addCriterion("ENSHORTNAME <>", value, "enshortname");
            return (Criteria) this;
        }

        public Criteria andEnshortnameGreaterThan(String value) {
            addCriterion("ENSHORTNAME >", value, "enshortname");
            return (Criteria) this;
        }

        public Criteria andEnshortnameGreaterThanOrEqualTo(String value) {
            addCriterion("ENSHORTNAME >=", value, "enshortname");
            return (Criteria) this;
        }

        public Criteria andEnshortnameLessThan(String value) {
            addCriterion("ENSHORTNAME <", value, "enshortname");
            return (Criteria) this;
        }

        public Criteria andEnshortnameLessThanOrEqualTo(String value) {
            addCriterion("ENSHORTNAME <=", value, "enshortname");
            return (Criteria) this;
        }

        public Criteria andEnshortnameLike(String value) {
            addCriterion("ENSHORTNAME like", value, "enshortname");
            return (Criteria) this;
        }

        public Criteria andEnshortnameNotLike(String value) {
            addCriterion("ENSHORTNAME not like", value, "enshortname");
            return (Criteria) this;
        }

        public Criteria andEnshortnameIn(List<String> values) {
            addCriterion("ENSHORTNAME in", values, "enshortname");
            return (Criteria) this;
        }

        public Criteria andEnshortnameNotIn(List<String> values) {
            addCriterion("ENSHORTNAME not in", values, "enshortname");
            return (Criteria) this;
        }

        public Criteria andEnshortnameBetween(String value1, String value2) {
            addCriterion("ENSHORTNAME between", value1, value2, "enshortname");
            return (Criteria) this;
        }

        public Criteria andEnshortnameNotBetween(String value1, String value2) {
            addCriterion("ENSHORTNAME not between", value1, value2, "enshortname");
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