package com.sht.po;

import java.util.Date;

public class Messages {
    private Object id;

    private Object launcher;

    private Object receiver;

    private String text;

    private Date createtime;

    public Object getId() {
        return id;
    }

    public void setId(Object id) {
        this.id = id;
    }

    public Object getLauncher() {
        return launcher;
    }

    public void setLauncher(Object launcher) {
        this.launcher = launcher;
    }

    public Object getReceiver() {
        return receiver;
    }

    public void setReceiver(Object receiver) {
        this.receiver = receiver;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text == null ? null : text.trim();
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }
}