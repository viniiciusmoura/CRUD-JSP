/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Modelo.Usuario;
import DAO.ErroDAO;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Vinícius Moura
 */
public class UsuarioDaoClasse implements AutoCloseable {
    Connection con;
    public UsuarioDaoClasse()throws ErroDAO{
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con= DriverManager.getConnection("jdbc:mysql://localhost:3306/crud?useSSL=false","root","123456");
        } catch (ClassNotFoundException | SQLException ex) {
            throw new ErroDAO(ex);
        } 
    }
    
    public JSONObject createUsuario (Usuario user) throws ErroDAO{
        JSONObject obj = new JSONObject();
        try {
            PreparedStatement ps=con.prepareStatement("INSERT INTO usuario(nome,sobrenome,idade) VALUES (?,?,?);",PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, user.getNome());
            ps.setString(2, user.getSobrenome());
            ps.setInt(3, user.getIdade());
            ps.executeUpdate();
            ResultSet rs=ps.getGeneratedKeys();
            if(rs.next())
            {
                user.setCodigo(rs.getInt(1));
            }
            ps.close();
            obj.put("nome", user.getNome());
            obj.put("sobrenome", user.getSobrenome());
            obj.put("idade",user.getIdade());
            return obj;
        } catch (SQLException ex) {
            throw new ErroDAO(ex);
        }
        
    }
    
    public JSONArray readUsers() throws ErroDAO {
        JSONArray users=new JSONArray();
        try {
            PreparedStatement ps=con.prepareStatement("select * from usuario");
            ResultSet rs=ps.executeQuery();
            while(rs.next())
            {
                JSONObject obj = new JSONObject();
                obj.put("id",rs.getInt(1));
                obj.put("nome", rs.getString(2));
                obj.put("sobrenome", rs.getString(3));
                obj.put("idade", rs.getInt(4));
                users.add(obj);
            }
            
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            throw new ErroDAO(ex);
        }
        return users;
    }
    
    public Usuario seachUser(int id) throws ErroDAO {
        Usuario user=null;
        try {
            PreparedStatement ps=con.prepareStatement("select * from usuario where codigo=?");
            ps.setInt(1, id);
            ResultSet rs=ps.executeQuery();
            while(rs.next())
            {
                user=new Usuario(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getInt(4));
            }
            
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            throw new ErroDAO(ex);
        }
        return user;
    }
    public JSONObject editar(Usuario u) throws ErroDAO {
        JSONObject obj = new JSONObject();
        try{
            PreparedStatement ps=con.prepareStatement("update usuario set nome=?,sobrenome=?,idade=? where codigo=?");
            ps.setString(1, u.getNome());
            ps.setString(2, u.getSobrenome());
            ps.setInt(3, u.getIdade());
            ps.setInt(4, u.getCodigo());
            obj.put("nome", u.getNome());
            if(ps.executeUpdate()>0)
                ps.close();
        }catch (SQLException ex) {
            throw new ErroDAO(ex);
        }
        return obj;
    }
    
    public void remover(int codigo) throws ErroDAO {
        try {
            PreparedStatement ps=con.prepareStatement("delete from usuario where codigo=?");
            ps.setInt(1, codigo);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException ex) {
            throw new ErroDAO(ex);
        }
    }

    
    @Override
    public void close() throws Exception {
       try {
            con.close();
        } catch (SQLException ex) {
            throw new IOException(ex);
        }
    }
    
    
    
    
    
}
