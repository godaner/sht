package com.sht.po;

import java.util.Date;

public class AdminsRoles {
    private String id;

    private String admin;

    private String role;

    private Date granttime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAdmin() {
        return admin;
    }

    public void setAdmin(String admin) {
        this.admin = admin;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Date getGranttime() {
        return granttime;
    }

    public void setGranttime(Date granttime) {
        this.granttime = granttime;
    }
}