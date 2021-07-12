package com.anh.practicepe;

import java.io.Serializable;

public class Student implements Serializable {
    private int id;
    private String name;
    private String classRoom;

    public Student(String name, String classRoom) {
        this.name = name;
        this.classRoom = classRoom;
    }

    public Student(int id, String name, String classRoom) {
        this.id = id;
        this.name = name;
        this.classRoom = classRoom;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getClassRoom() {
        return classRoom;
    }

    public void setClassRoom(String classRoom) {
        this.classRoom = classRoom;
    }
}
