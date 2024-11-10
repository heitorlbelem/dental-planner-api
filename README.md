# Requisitos Funcionais
    [x] Deve ser possível cadastrar um paciente
    [x] Deve ser possível cadastrar o endereço para um paciente
    [x] Deve ser possível cadastrar um dentista
    [x] Deve ser possível criar um agendamento para o par paciente/dentista
    [x] Deve ser possível cancelar um agendamento criado
    [x] Deve ser possível confirmar um agendamento criado
    [x] Deve ser possível finalizar um agendamento criado

# Regras de Negócio
### Sobre o status do agendamento
    [x] Um agendamento deve ser criado sempre com o status "pendente"
    [x] Um agendamento "pendente" só pode ser "confirmado" ou "cancelado"
    [x] Um agendamento "confirmado" só pode ser "finalizado" ou "cancelado"
    [x] Um agendamento "cancelado" não pode mudar para outro status
    [x] Um agendamento "finalizado" não pode mudar para outro status
### Sobre a criação do agendamento
    [x] Um agendamento só pode ser marcado para uma data posterior ao momento de criação
    [x] Um agendamento só pode ser marcado para uma data em que o dentista esteja disponível, ou seja, em que não haja outro agendamento, com outro paciente, para o mesmo dentista
