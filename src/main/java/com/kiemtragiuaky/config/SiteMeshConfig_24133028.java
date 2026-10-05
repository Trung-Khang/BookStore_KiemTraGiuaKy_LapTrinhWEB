package com.kiemtragiuaky.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.sitemesh.webapp.DispatchMode;

public class SiteMeshConfig_24133028 extends ConfigurableSiteMeshFilter {
    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder.setDispatchMode(DispatchMode.INCLUDE)
                .setDecoratorPrefix("/WEB-INF/decorators/")
                .addExcludedPath("/assets/*")
                .addExcludedPath("/foundation/*")
                .addDecoratorPath("/*", "user.jsp")
                .addDecoratorPath("/admin/*", "admin.jsp");
    }
}
