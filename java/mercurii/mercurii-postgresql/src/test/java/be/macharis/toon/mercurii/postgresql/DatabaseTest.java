package be.macharis.toon.mercurii.postgresql;

import be.macharis.toon.mercurii.postgresql.model.Owner;
import java.util.List;
import java.util.Set;
import static java.util.stream.Collectors.toSet;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;

/**
 * @author Toon Macharis
 */
public class DatabaseTest {
    @Test
    public void testOwners() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("mercurii");
        EntityManager em = emf.createEntityManager();
        try {
            Set<String> expectedUUIDs = Set.of(
                    "3bb0694e-4330-4d12-95b8-5046385b16f2",
                    "b52daf22-b242-4edb-a588-a02332df238f",
                    "7324a92c-e22f-4e08-bad1-dd4e97f40914"
            );
            
            List<Owner> owners = em.createQuery("SELECT o FROM Owner o").getResultList();
            Set<String> actualUUIDs = owners.stream().map(owner -> owner.getId().toString().toLowerCase()).collect(toSet());
            
            assertEquals(3, owners.size());
            assertEquals(expectedUUIDs, actualUUIDs);
        } finally {
            em.close();
            emf.close();
        }
    }
}
