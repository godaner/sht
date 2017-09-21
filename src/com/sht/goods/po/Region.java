package com.sht.goods.po;

import java.math.BigDecimal;

public class Region {
    private BigDecimal regionId;

    private String regionCode;

    private String regionName;

    private BigDecimal parentId;

    private BigDecimal regionLevel;

    private BigDecimal regionOrder;

    private String regionNameEn;

    private String regionShortnameEn;

    public BigDecimal getRegionId() {
        return regionId;
    }

    public void setRegionId(BigDecimal regionId) {
        this.regionId = regionId;
    }

    public String getRegionCode() {
        return regionCode;
    }

    public void setRegionCode(String regionCode) {
        this.regionCode = regionCode == null ? null : regionCode.trim();
    }

    public String getRegionName() {
        return regionName;
    }

    public void setRegionName(String regionName) {
        this.regionName = regionName == null ? null : regionName.trim();
    }

    public BigDecimal getParentId() {
        return parentId;
    }

    public void setParentId(BigDecimal parentId) {
        this.parentId = parentId;
    }

    public BigDecimal getRegionLevel() {
        return regionLevel;
    }

    public void setRegionLevel(BigDecimal regionLevel) {
        this.regionLevel = regionLevel;
    }

    public BigDecimal getRegionOrder() {
        return regionOrder;
    }

    public void setRegionOrder(BigDecimal regionOrder) {
        this.regionOrder = regionOrder;
    }

    public String getRegionNameEn() {
        return regionNameEn;
    }

    public void setRegionNameEn(String regionNameEn) {
        this.regionNameEn = regionNameEn == null ? null : regionNameEn.trim();
    }

    public String getRegionShortnameEn() {
        return regionShortnameEn;
    }

    public void setRegionShortnameEn(String regionShortnameEn) {
        this.regionShortnameEn = regionShortnameEn == null ? null : regionShortnameEn.trim();
    }
}