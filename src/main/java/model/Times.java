package model;

public class Times {
	private int cod_time;
    private String nome;
    private String cidade;
    private String estadio;
    private String material_esportivo;
    
	public int getCod_time() {
		return cod_time;
	}
	public void setCod_time(int cod_time) {
		this.cod_time = cod_time;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getCidade() {
		return cidade;
	}
	public void setCidade(String cidade) {
		this.cidade = cidade;
	}
	public String getEstadio() {
		return estadio;
	}
	public void setEstadio(String estadio) {
		this.estadio = estadio;
	}
	public String getMaterial_esportivo() {
		return material_esportivo;
	}
	public void setMaterial_esportivo(String material_esportivo) {
		this.material_esportivo = material_esportivo;
	}
	
	@Override
	public String toString() {
		return "Times [cod_time=" + cod_time + ", nome=" + nome + ", cidade=" + cidade + ", estadio=" + estadio
				+ ", material_esportivo=" + material_esportivo + "]";
	}
	
	
}
