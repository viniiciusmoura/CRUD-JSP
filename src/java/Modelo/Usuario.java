/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author Vinícius Moura
 */
public class Usuario {
    private String nome, sobrenome;
    private int idade,codigo;

    public Usuario(int codigo,String nome, String sobrenome, int idade) {
        this.codigo = codigo;
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.idade = idade;
        
    }

    public String getNome() {
        return nome;
    }

    public String getSobrenome() {
        return sobrenome;
    }

    public int getIdade() {
        return idade;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }
    
    
    
}
