/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelos;

/**
 *
 * @author BORJA
 */
public class Candidato {
    
    private int id;
    private String nombre;
    private int orden;
    private int idPartido;

    public Candidato(int id, String nombre, int orden, int idPartido) {
        this.id = id;
        this.nombre = nombre;
        this.orden = orden;
        this.idPartido = idPartido;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getOrden() {
        return orden;
    }

    public void setOrden(int orden) {
        this.orden = orden;
    }

    public int getIdPartido() {
        return idPartido;
    }

    public void setIdPartido(int idPartido) {
        this.idPartido = idPartido;
    }
    
    
    
    
    
}
