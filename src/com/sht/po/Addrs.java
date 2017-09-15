package com.sht.po;

import java.math.BigDecimal;

public class Addrs {
    private Object id;

    private Object master;

    private BigDecimal region;

    private Object detail;

    private Object pohne;

    private Object realname;

    private Short isdefault;

    private String postcode;

    public Object getId() {
        return id;
    }

    public void setId(Object id) {
        this.id = id;
    }

    public Object getMaster() {
        return master;
    }

    public void setMaster(Object master) {
        this.master = master;
    }

    public BigDecimal getRegion() {
        return region;
    }

    public void setRegion(BigDecimal region) {
        this.region = region;
    }

    public Object getDetail() {
        return detail;
    }

    public void setDetail(Object detail) {
        this.detail = detail;
    }

    public Object getPohne() {
        return pohne;
    }

    public void setPohne(Object pohne) {
        this.pohne = pohne;
    }

    public Object getRealname() {
        return realname;
    }

    public void setRealname(Object realname) {
        this.realname = realname;
    }

    public Short getIsdefault() {
        return isdefault;
    }

    public void setIsdefault(Short isdefault) {
        this.isdefault = isdefault;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode == null ? null : postcode.trim();
    }
}