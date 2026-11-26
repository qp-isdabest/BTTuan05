package vn.iotstar.entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "categories")
public class Category implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", columnDefinition = "NVARCHAR(255) NOT NULL")
    private String name;

    @Column(name = "images", length = 500)
    private String images;

    @Column(name = "status")
    private int status;

    public Category() {
    }

    public Category(Long id, String name, String images, int status) {
        this.id = id;
        this.name = name;
        this.images = images;
        this.status = status;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", images='" + images + '\'' +
                ", status=" + status +
                '}';
    }
}
