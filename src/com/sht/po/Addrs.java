package com.sht.po;

public class Addrs {
    private String id;

    private String master;

    private Double region;

    private String detail;

    private String pohne;

    private String realname;

    private Short isdefault;

    private String postcode;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMaster() {
        return master;
    }

    public void setMaster(String master) {
        this.master = master;
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
        this.detail = detail;
    }

    public String getPohne() {
        return pohne;
    }

    public void setPohne(String pohne) {
        this.pohne = pohne;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
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