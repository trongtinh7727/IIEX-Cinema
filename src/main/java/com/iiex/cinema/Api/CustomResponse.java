package com.iiex.cinema.Api;

import com.iiex.cinema.Model.Movie;

import java.util.List;

public class CustomResponse <T>{
    private boolean status;
    private List<T> data;

    private String message;

    public CustomResponse(boolean status, List<T> data) {
        this.status = status;
        this.data = data;
    }

    public CustomResponse(boolean status, List<T> data, String message) {
        this.status = status;
        this.data = data;
        this.message = message;
    }

    public CustomResponse(boolean status, String message) {
        this.status = status;
        this.message = message;
    }

    public boolean isStatus() {
        return status;
    }

    public List<T> getData() {
        return data;
    }

    public String getMessage(){ return  message;}
}
