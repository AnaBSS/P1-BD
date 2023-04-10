package model;

public class Grupos {
	private String grupo;
    private String nome_time;

    public String getGrupo() {
        return grupo;
    }
    public void setGrupo(String grupo) {
        this.grupo = grupo;
    }
    public String getNome_time() {
        return nome_time;
    }
    public void setNome_time(String nome_time) {
        this.nome_time = nome_time;
    }
    @Override
    public String toString() {
        return "Grupos [grupo=" + grupo + ", nome_time=" + nome_time + "]";
    }
}
