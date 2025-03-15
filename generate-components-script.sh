#!/bin/bash
# Script para criar componentes placeholder para as rotas do GERT
# Parte 2: Estoque, Técnicos e Relatórios

# Cores para mensagens no console
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para criar um componente
create_component() {
  local path=$1
  local name=$2
  local title=$3

  # Criar diretórios
  mkdir -p "src/app/features/$path/pages/$name"

  # Criar arquivo TS do componente
  cat > "src/app/features/$path/pages/$name/$name.component.ts" << EOF
import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-$name',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './$name.component.html',
  styleUrl: './$name.component.scss'
})
export class ${name^}Component {}
EOF

  # Criar arquivo HTML do componente
  cat > "src/app/features/$path/pages/$name/$name.component.html" << EOF
<div class="container-fluid">
  <div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
      <h2>$title</h2>
      <button class="btn btn-secondary" routerLink="/$path">Voltar</button>
    </div>
    <div class="card-body">
      <p class="lead">Esta página será implementada em breve.</p>
      <div class="text-center my-4">
        <i class="fas fa-code fa-5x text-primary"></i>
      </div>
    </div>
  </div>
</div>
EOF

  # Criar arquivo SCSS do componente
  cat > "src/app/features/$path/pages/$name/$name.component.scss" << EOF
// Estilos específicos para o componente $name
EOF

  echo -e "${GREEN}Componente $name criado em $path${NC}"
}

# Criar arquivo de rotas para cada módulo
create_routes_file() {
  local path=$1
  local componentName=$2

  mkdir -p "src/app/features/$path"

  cat > "src/app/features/$path/$path.routes.ts" << EOF
import { Routes } from '@angular/router';

export const ${path^^}_ROUTES: Routes = [
  {
    path: '',
    loadComponent: () =>
      import('./pages/lista-$componentName/lista-$componentName.component').then(m => m.Lista${componentName^}Component)
  },
  {
    path: 'novo',
    loadComponent: () =>
      import('./pages/novo-$componentName/novo-$componentName.component').then(m => m.Novo${componentName^}Component)
  },
  {
    path: ':id',
    loadComponent: () =>
      import('./pages/detalhe-$componentName/detalhe-$componentName.component').then(m => m.Detalhe${componentName^}Component)
  },
  {
    path: ':id/editar',
    loadComponent: () =>
      import('./pages/editar-$componentName/editar-$componentName.component').then(m => m.Editar${componentName^}Component)
  }
];
EOF

  echo -e "${GREEN}Arquivo de rotas $path.routes.ts criado${NC}"
}

# Criar arquivo de rotas personalizado para Relatórios
create_reports_routes_file() {
  mkdir -p "src/app/features/relatorios"

  cat > "src/app/features/relatorios/relatorios.routes.ts" << EOF
import { Routes } from '@angular/router';

export const RELATORIOS_ROUTES: Routes = [
  {
    path: '',
    loadComponent: () =>
      import('./pages/dashboard-relatorios/dashboard-relatorios.component').then(m => m.DashboardRelatoriosComponent)
  },
  {
    path: 'chamados',
    loadComponent: () =>
      import('./pages/relatorio-chamados/relatorio-chamados.component').then(m => m.RelatorioChamadosComponent)
  },
  {
    path: 'financeiro',
    loadComponent: () =>
      import('./pages/relatorio-financeiro/relatorio-financeiro.component').then(m => m.RelatorioFinanceiroComponent)
  },
  {
    path: 'estoque',
    loadComponent: () =>
      import('./pages/relatorio-estoque/relatorio-estoque.component').then(m => m.RelatorioEstoqueComponent)
  },
  {
    path: 'tecnicos',
    loadComponent: () =>
      import('./pages/relatorio-tecnicos/relatorio-tecnicos.component').then(m => m.RelatorioTecnicosComponent)
  }
];
EOF

  echo -e "${GREEN}Arquivo de rotas personalizado relatorios.routes.ts criado${NC}"
}

echo -e "${BLUE}Criando componentes para o módulo de Estoque...${NC}"

# Criar arquivo de rotas para Estoque
create_routes_file "estoque" "peca"

# Criar componentes para Estoque
create_component "estoque" "lista-pecas" "Gestão de Peças"
create_component "estoque" "nova-peca" "Nova Peça"
create_component "estoque" "detalhe-peca" "Detalhes da Peça"
create_component "estoque" "editar-peca" "Editar Peça"

# Componentes adicionais específicos do estoque
create_component "estoque" "entradas-estoque" "Registro de Entradas"
create_component "estoque" "lista-fornecedores" "Fornecedores"

echo -e "${BLUE}Criando componentes para o módulo de Técnicos...${NC}"

# Criar arquivo de rotas para Técnicos
create_routes_file "tecnicos" "tecnico"

# Criar componentes para Técnicos
create_component "tecnicos" "lista-tecnicos" "Equipe Técnica"
create_component "tecnicos" "novo-tecnico" "Novo Técnico"
create_component "tecnicos" "detalhe-tecnico" "Perfil do Técnico"
create_component "tecnicos" "editar-tecnico" "Editar Técnico"

echo -e "${BLUE}Criando componentes para o módulo de Relatórios...${NC}"

# Criar arquivo de rotas personalizado para Relatórios
create_reports_routes_file

# Criar componentes para Relatórios
create_component "relatorios" "dashboard-relatorios" "Central de Relatórios"
create_component "relatorios" "relatorio-chamados" "Relatório de Chamados"
create_component "relatorios" "relatorio-financeiro" "Relatório Financeiro"
create_component "relatorios" "relatorio-estoque" "Relatório de Estoque"
create_component "relatorios" "relatorio-tecnicos" "Relatório de Desempenho"

# Criar componentes placeholder para lista de chamados (caso não exista ainda)
if [ ! -d "src/app/features/chamados/pages/lista-chamados" ]; then
  create_component "chamados" "lista-chamados" "Lista de Chamados"
fi

echo -e "${GREEN}Segunda parte da criação de componentes concluída!${NC}"
echo -e "${BLUE}Todos os componentes placeholder foram criados com sucesso.${NC}"
