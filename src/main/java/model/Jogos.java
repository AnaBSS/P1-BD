package model;

import java.time.LocalDate;

public class Jogos {
	 private String nome_timeA;
	    private String nome_timeB;
	    private int gols_timeA;
	    private int gols_timeB;
	    private LocalDate data_jogo;
	    public String getNome_timeA() {
	        return nome_timeA;
	    }
	    public void setNome_timeA(String nome_timeA) {
	        this.nome_timeA = nome_timeA;
	    }
	    public String getNome_timeB() {
	        return nome_timeB;
	    }
	    public void setNome_timeB(String nome_timeB) {
	        this.nome_timeB = nome_timeB;
	    }
	    public int getGols_timeA() {
	        return gols_timeA;
	    }
	    public void setGols_timeA(int gols_timeA) {
	        this.gols_timeA = gols_timeA;
	    }
	    public int getGols_timeB() {
	        return gols_timeB;
	    }
	    public void setGols_timeB(int gols_timeB) {
	        this.gols_timeB = gols_timeB;
	    }
	    public LocalDate getData_jogo() {
	        return data_jogo;
	    }
	    public void setData_jogo(LocalDate data_jogo) {
	        this.data_jogo = data_jogo;
	    }
	    @Override
	    public String toString() {
	        return "Jogos [nome_timeA=" + nome_timeA + ", nome_timeB=" + nome_timeB + ", gols_timeA=" + gols_timeA
	                + ", gols_timeB=" + gols_timeB + ", data_jogo=" + data_jogo + "]";
	    }
}
