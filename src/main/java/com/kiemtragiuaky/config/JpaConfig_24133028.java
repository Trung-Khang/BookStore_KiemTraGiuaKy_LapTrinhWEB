package com.kiemtragiuaky.config;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.HashMap;
import java.util.Map;

public final class JpaConfig_24133028 {
    private static final String PERSISTENCE_UNIT = "bookStorePersistenceUnit_24133028";
    private static volatile EntityManagerFactory entityManagerFactory;
    private static volatile String unavailableReason;

    private JpaConfig_24133028() {
    }

    public static synchronized void initialize() {
        if (entityManagerFactory != null || unavailableReason != null) {
            return;
        }

        String host = requiredEnvironment("DB_HOST");
        String port = requiredEnvironment("DB_PORT");
        String database = requiredEnvironment("DB_NAME");
        String username = requiredEnvironment("DB_USER");
        String password = requiredEnvironment("DB_PASSWORD");
        if (host == null || port == null || database == null || username == null || password == null) {
            unavailableReason = "Thieu bien moi truong ket noi SQL Server.";
            return;
        }

        boolean encrypt = booleanEnvironment("DB_ENCRYPT", true);
        boolean trustServerCertificate = booleanEnvironment("DB_TRUST_SERVER_CERTIFICATE", true);
        Map<String, Object> properties = new HashMap<>();
        properties.put("jakarta.persistence.jdbc.driver", "com.microsoft.sqlserver.jdbc.SQLServerDriver");
        properties.put("jakarta.persistence.jdbc.url", "jdbc:sqlserver://" + host + ":" + port
                + ";databaseName=" + database + ";encrypt=" + encrypt
                + ";trustServerCertificate=" + trustServerCertificate + ";");
        properties.put("jakarta.persistence.jdbc.user", username);
        properties.put("jakarta.persistence.jdbc.password", password);
        entityManagerFactory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT, properties);
    }

    public static EntityManagerFactory getEntityManagerFactory() {
        if (entityManagerFactory == null) {
            throw new IllegalStateException(unavailableReason == null
                    ? "JPA chua duoc khoi tao."
                    : unavailableReason);
        }
        return entityManagerFactory;
    }

    public static boolean isAvailable() {
        return entityManagerFactory != null;
    }

    public static String getUnavailableReason() {
        return unavailableReason;
    }

    public static synchronized void close() {
        if (entityManagerFactory != null) {
            entityManagerFactory.close();
            entityManagerFactory = null;
        }
    }

    private static String requiredEnvironment(String name) {
        String value = System.getenv(name);
        return value == null || value.isBlank() ? null : value;
    }

    private static boolean booleanEnvironment(String name, boolean defaultValue) {
        String value = System.getenv(name);
        return value == null || value.isBlank() ? defaultValue : Boolean.parseBoolean(value);
    }
}

