package com.sht.po;

public class GoodsImgs {
    private String id;

    private String owner;

    private String img;

    private Double main;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner == null ? null : owner.trim();
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img == null ? null : img.trim();
    }

    public Double getMain() {
        return main;
    }

    public void setMain(Double main) {
        this.main = main;
    }
}