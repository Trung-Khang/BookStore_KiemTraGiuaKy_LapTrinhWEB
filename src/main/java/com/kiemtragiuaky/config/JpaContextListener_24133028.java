package com.kiemtragiuaky.config;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class JpaContextListener_24133028 implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent event) {
        JpaConfig_24133028.initialize();
        if (!JpaConfig_24133028.isAvailable()) {
            event.getServletContext().log("JPA unavailable: " + JpaConfig_24133028.getUnavailableReason());
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        JpaConfig_24133028.close();
    }
}

