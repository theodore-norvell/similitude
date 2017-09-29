package com.mun.entity;

import javax.persistence.*;

/**
 * Created by wanhui on 13/03/2017.
 */
@Entity
@Table(name = "circuit", schema = "circuit")
public class CircuitEntity {
    private int id;
    private String name;
    private int userId;
    private String circuitFileAddress;
    private String circuitSnapshoot;

    @Id
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "name", nullable = false, length = 45)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "user_id", nullable = false)
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "circuit_file_address", nullable = false, length = 100)
    public String getCircuitFileAddress() {
        return circuitFileAddress;
    }

    public void setCircuitFileAddress(String circuitFileAddress) {
        this.circuitFileAddress = circuitFileAddress;
    }

    @Basic
    @Column(name = "circuit_snapshoot", nullable = false, length = 100)
    public String getCircuitSnapshoot() {
        return circuitSnapshoot;
    }

    public void setCircuitSnapshoot(String circuitSnapshoot) {
        this.circuitSnapshoot = circuitSnapshoot;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CircuitEntity that = (CircuitEntity) o;

        if (id != that.id) return false;
        if (userId != that.userId) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (circuitFileAddress != null ? !circuitFileAddress.equals(that.circuitFileAddress) : that.circuitFileAddress != null)
            return false;
        if (circuitSnapshoot != null ? !circuitSnapshoot.equals(that.circuitSnapshoot) : that.circuitSnapshoot != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + userId;
        result = 31 * result + (circuitFileAddress != null ? circuitFileAddress.hashCode() : 0);
        result = 31 * result + (circuitSnapshoot != null ? circuitSnapshoot.hashCode() : 0);
        return result;
    }
}
