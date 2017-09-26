package com.sht.po;

import java.sql.Timestamp;

public class Goods {
    private String id;

    private String title;

    private String description;

    private Double sprice;

    private Double price;

    private Short condition;

    private Double region;

    private Short status;

    private Timestamp createtime;

    private String owner;

    private String buyer;

    private Double browsenumber;

    private Timestamp lastupdatetime;

    private Timestamp buytime;

    private Timestamp finishtime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public Double getSprice() {
        return sprice;
    }

    public void setSprice(Double sprice) {
        this.sprice = sprice;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Short getCondition() {
        return condition;
    }

    public void setCondition(Short condition) {
        this.condition = condition;
    }

    public Double getRegion() {
        return region;
    }

    public void setRegion(Double region) {
        this.region = region;
    }

    public Short getStatus() {
        return status;
    }

    public void setStatus(Short status) {
        this.status = status;
    }

    public Timestamp getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Timestamp createtime) {
        this.createtime = createtime;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner == null ? null : owner.trim();
    }

    public String getBuyer() {
        return buyer;
    }

    public void setBuyer(String buyer) {
        this.buyer = buyer == null ? null : buyer.trim();
    }

    public Double getBrowsenumber() {
        return browsenumber;
    }

    public void setBrowsenumber(Double browsenumber) {
        this.browsenumber = browsenumber;
    }

    public Timestamp getLastupdatetime() {
        return lastupdatetime;
    }

    public void setLastupdatetime(Timestamp lastupdatetime) {
        this.lastupdatetime = lastupdatetime;
    }

    public Timestamp getBuytime() {
        return buytime;
    }

    public void setBuytime(Timestamp buytime) {
        this.buytime = buytime;
    }

    public Timestamp getFinishtime() {
        return finishtime;
    }

    public void setFinishtime(Timestamp finishtime) {
        this.finishtime = finishtime;
    }
}