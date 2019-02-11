/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author carlos
 */
public class PorraInfo {
    private int golesLocal;
    private int golesVisitante;
    private int apuestas;

    public int getGolesLocal() {
        return golesLocal;
    }

    public void setGolesLocal(int golesLocal) {
        this.golesLocal = golesLocal;
    }

    public int getGolesVisitante() {
        return golesVisitante;
    }

    public void setGolesVisitante(int golesVisitante) {
        this.golesVisitante = golesVisitante;
    }

    public int getApuestas() {
        return apuestas;
    }

    public void setApuestas(int apuestas) {
        this.apuestas = apuestas;
    }
    
    public void nuevaApuesta() {
        this.apuestas++;
    }

    public PorraInfo(int golesLocal, int golesVisitante) {
        this.golesLocal = golesLocal;
        this.golesVisitante = golesVisitante;
        this.apuestas = 1;
    }

    @Override
    public String toString() {
        return "PorraInfo{" + "golesLocal=" + golesLocal + ", golesVisitante=" + golesVisitante + ", apuestas=" + apuestas + '}';
    }
    
    
}
