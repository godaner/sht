package com.sht.po;



public class Region {
    private Double id;

    private String code;

    private String name;

    private Double pid;

    private Double leve;

    private Double orde;

    private String enname;

    private String enshortname;

    public Double getId() {
        return id;
    }

    public void setId(Double id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code == null ? null : code.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Double getPid() {
        return pid;
    }

    public void setPid(Double pid) {
        this.pid = pid;
    }

    public Double getLeve() {
        return leve;
    }

    public void setLeve(Double leve) {
        this.leve = leve;
    }

    public Double getOrde() {
        return orde;
    }

    public void setOrde(Double orde) {
        this.orde = orde;
    }

    public String getEnname() {
        return enname;
    }

    public void setEnname(String enname) {
        this.enname = enname == null ? null : enname.trim();
    }

    public String getEnshortname() {
        return enshortname;
    }

    public void setEnshortname(String enshortname) {
        this.enshortname = enshortname == null ? null : enshortname.trim();
    }
}