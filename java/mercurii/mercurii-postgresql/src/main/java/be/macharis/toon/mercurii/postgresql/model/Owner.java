package be.macharis.toon.mercurii.postgresql.model;

import java.util.UUID;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * @author Toon Macharis
 */
@Entity
public class Owner {
    @Id
    @Column(name = "owner_id")
    private UUID id;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }
}
