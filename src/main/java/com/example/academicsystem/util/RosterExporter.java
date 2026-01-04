package com.example.academicsystem.util;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;
import org.springframework.stereotype.Component;

import java.io.ByteArrayOutputStream;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

@Component
public class RosterExporter {

    private final Configuration configuration;

    public RosterExporter() {
        configuration = new Configuration(Configuration.VERSION_2_3_31);
        configuration.setClassForTemplateLoading(this.getClass(), "/");
        configuration.setDefaultEncoding("UTF-8");
        configuration.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
    }

    public byte[] generateRoster(Long classId, String term) {
        try {
            Template template = configuration.getTemplate("templates/roster.ftl");
            Map<String, Object> model = new HashMap<>();
            model.put("classId", classId);
            model.put("term", term);
            model.put("placeholder", "示例点名册，请根据实际业务填充学生列表");
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            template.process(model, new OutputStreamWriter(bos, StandardCharsets.UTF_8));
            return bos.toByteArray();
        } catch (Exception e) {
            throw new RuntimeException("导出点名册失败", e);
        }
    }
}
