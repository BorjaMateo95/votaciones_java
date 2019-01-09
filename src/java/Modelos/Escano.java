/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelos;

import java.util.ArrayList;

/**
 *
 * @author BORJA
 */
public class Escano {
    
    private int id;
    private Partido partido;
    private ArrayList<Candidato> listCandidatos;

    public Escano(int id, Partido partido, ArrayList<Candidato> listCandidatos) {
        this.id = id;
        this.partido = partido;
        this.listCandidatos = listCandidatos;
    }
    
    public Escano(Partido partido, ArrayList<Candidato> listCandidatos) {
        this.partido = partido;
        this.listCandidatos = listCandidatos;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Partido getPartido() {
        return partido;
    }

    public void setPartido(Partido partido) {
        this.partido = partido;
    }

    public ArrayList<Candidato> getListCandidatos() {
        return listCandidatos;
    }

    public void setListCandidatos(ArrayList<Candidato> listCandidatos) {
        this.listCandidatos = listCandidatos;
    }
    
    
    
    
    
}
