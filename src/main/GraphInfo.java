package main;

public class GraphInfo {
    private double x;
    private double y;
    private int r;
    public boolean isHit;

    public GraphInfo(double x, double y, int r){
        this.x = x;
        this.y = y;
        this.r = r;
        isHit = ((x<=0 && y>=0 && y<=(2*x+r)) || (x<=0 && y<=0 && x*x+y*y<=r*r/4) || (x>=0 && y<=0 && x<=r && y>=-r));
    }

    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public double getR() {
        return r;
    }

    public String toString(){
        return "X="+x+", Y="+y+", R="+r+(isHit ? " Да" : " Нет");
    }
    public boolean isHit(){
        return isHit;
    }
}