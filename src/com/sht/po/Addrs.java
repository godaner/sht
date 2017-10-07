package com.sht.po;

public class Addrs {
    private String id;

    private String master;

    private Double region;

    private String detail;

    private String phone;

    private String realname;

    private Short isdefault;

    private String postcode;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getMaster() {
        return master;
    }

    public void setMaster(String master) {
        this.master = master == null ? null : master.trim();
    }

    public Double getRegion() {
        return region;
    }

    public void setRegion(Double region) {
        this.region = region;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail == null ? null : detail.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname == null ? null : realname.trim();
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