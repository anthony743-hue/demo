package com.example.forage.entity;

import java.util.Map;

public class ApiResponse {
    private boolean success;
    private String message;
    private Map<String, String> errors; // erreurs champ par champ (optionnel)
    private Object data;
    public boolean isSuccess() {
        return success;
    }
    public void setSuccess(boolean success) {
        this.success = success;
    }
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }
    public Map<String, String> getErrors() {
        return errors;
    }
    public void setErrors(Map<String, String> errors) {
        this.errors = errors;
    }
    public Object getData() {
        return data;
    }
    public void setData(Object data) {
        this.data = data;
    } 
}
