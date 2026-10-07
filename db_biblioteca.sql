CREATE TABLE leitores (
	id serial PRIMARY KEY,
	nome VARCHAR(200) not null,
	email VARCHAR(100) unique not null,
	cpf VARCHAR(11) unique not null,
	telefone varchar(11) not null,
	data_cadastro TIMESTAMP default CURRENT_TIMESTAMP
)


CREATE TABLE categorias(
	id serial primary key,
	nome VARCHAR(100) not null
)


create table livros(
	id serial primary key,
	categoria_id int references categorias(id) on delete cascade,
	titulo varchar(100) not null,
	isbn VARCHAR(20) unique not null,
	taxa_diaria DECIMAL(10, 2) check(taxa_diaria > 0) not null,
	disponivel BOOLEAN DEFAULT True
)


create TABLE emprestimos(
	id serial primary key,
	leitor_id int REFERENCES leitores(id) on delete restrict,
	data_emprestimo TIMESTAMP default CURRENT_TIMESTAMP,
	status varchar check(status in ('Ativo', 'Devolvido', 'Atrasado')) default 'Ativo'
)


create table itens_emprestimo(
	id serial PRIMARY key,
	eprestimo_id int REFERENCES emprestimos(id),
	livro_id int REFERENCES livros(id),
	quantidade int not null check(quantidade >= 0),
	valor_diaria decimal(10, 2) not null check(valor_diaria >= 0)
)


-- ________________________________________________________________________________________________________________________________________

INSERT INTO categorias (nome) VALUES
('Ficção'),
('História'),
('Tecnologia');


INSERT INTO livros (categoria_id, titulo, isbn, taxa_diaria, disponivel) VALUES
(4, 'O Hobbit', '9780007525515', 6.50, TRUE),
(5, 'História do Brasil', '9788535902771', 4.00, TRUE),
(6, 'Introdução à Programação', '9788575226316', 7.50, TRUE);



INSERT INTO leitores (nome, email, cpf, telefone) VALUES
('Carlos Silva', 'carlos@gmail.com', '11111111111', '48999990001'),
('Ana Souza', 'ana@gmail.com', '22222222222', '48999990002'),
('João Pereira', 'joao@gmail.com', '33333333333', '48999990003');


INSERT INTO emprestimos (leitor_id, status) VALUES
(4, 'Ativo'),
(4, 'Devolvido'),
(5, 'Devolvido'),
(6, 'Atrasado');


INSERT INTO itens_emprestimo
(emprestimo_id, livro_id, quantidade, valor_diaria)
VALUES
(9, 10, 1, 6.50),
(10, 11, 1, 4.00),
(11, 12, 2, 7.50),
(12, 10, 1, 6.50);