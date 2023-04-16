package com.iiex.cinema.Api;

import com.iiex.cinema.Model.Movie;

import java.util.List;

public class CustomResponse <T>{
    private boolean status;
    private List<T> data;

    public CustomResponse(boolean status, List<T> data) {
        this.status = status;
        this.data = data;
    }

    public boolean isStatus() {
        return status;
    }

    public List<T> getData() {
        return data;
    }
}
