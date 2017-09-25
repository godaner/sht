package com.sht.po;

public class Region {
    private Integer id;

    private String code;

    private String name;

    private Integer pid;

    private Integer leve;

    private Integer orde;

    private String enname;

    private String enshortname;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
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

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getLeve() {
        return leve;
    }

    public void setLeve(Integer leve) {
        this.leve = leve;
    }

    public Integer getOrde() {
        return orde;
    }

    public void setOrde(Integer orde) {
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