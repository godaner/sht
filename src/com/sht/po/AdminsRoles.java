package com.sht.po;

import java.util.Date;

public class AdminsRoles {
    private Object id;

    private Object admin;

    private Object role;

    private Date granttime;

    public Object getId() {
        return id;
    }

    public void setId(Object id) {
        this.id = id;
    }

    public Object getAdmin() {
        return admin;
    }

    public void setAdmin(Object admin) {
        this.admin = admin;
    }

    public Object getRole() {
        return role;
    }

    public void setRole(Object role) {
        this.role = role;
    }

    public Date getGranttime() {
        return granttime;
    }

    public void setGranttime(Date granttime) {
        this.granttime = granttime;
    }
}