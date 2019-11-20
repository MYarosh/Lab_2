package main;

import java.util.ArrayList;
import java.util.List;

import java.util.ArrayList;
import java.util.List;

public class History {
    private List<GraphInfo> list;

    public History(){
        list = new ArrayList<GraphInfo>();
    }

    public void addPoint(GraphInfo point){
        list.add(point);
    }

    public List<GraphInfo> getList(){
        return list;
    }
}