export interface Usuario {
  id?: number;
  nome: string;
  email: string;
  senha?: string;
  cargo: string;
  ativo: boolean;
  dataCriacao?: Date;
  ultimoAcesso?: Date;
}
