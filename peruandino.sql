-- phpMyAdmin SQL Dump
-- version 4.9.10
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 25-11-2022 a las 15:16:21
-- Versión del servidor: 8.0.30
-- Versión de PHP: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_cafetin`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_arreglar_pedido` (IN `n_facturacion` INT, IN `n_mesa` INT, IN `n_trabajador` INT, IN `n_fecha` DATETIME, IN `n_estado` INT, IN `n_nombre` TEXT)   BEGIN 
DECLARE n_pedido int; 
DECLARE n_sql VARCHAR(500); 
SET @n_sql =CONCAT("INSERT INTO `pedido`(`id`, `id_mesa`, `id_empleado`, `fecha_registro`, `estado`, `nombre_cliente`) VALUES (NULL,'",n_mesa,"','",n_trabajador,"','",n_fecha,"','",n_estado,"','",n_nombre,"')"); 
PREPARE n1 FROM @n_sql;
EXECUTE n1;
set @n_pedido = LAST_INSERT_ID();
UPDATE `toma_pedido` SET `id_pedido` = @n_pedido WHERE `toma_pedido`.`id_facturacion` = n_facturacion; 
UPDATE `facturacion` SET `id_pedido` = @n_pedido WHERE `facturacion`.`id` = n_facturacion; 
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id` int NOT NULL,
  `nombre` varchar(75) NOT NULL,
  `estado` int NOT NULL DEFAULT '1',
  `id_tipo_servicio` int NOT NULL,
  `foto` varchar(255) NOT NULL DEFAULT 'defecto.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `nombre`, `estado`, `id_tipo_servicio`, `foto`) VALUES
(1, 'EMPANADAS', 1, 2, 'imgCat1.jpg'),
(2, 'SANDWICH', 1, 2, 'imgCat3.jpg'),
(3, 'ENSALADAS', 0, 2, 'imgCat2.jpg'),
(4, 'DESAYUNOS', 1, 2, 'imgCat4.jpg'),
(5, 'BEBIDAS CALIENTES', 1, 1, 'imgCat5.jpg'),
(6, 'TORTAS', 1, 1, 'imgCat7.jpg'),
(7, 'GUARNICIONES', 1, 2, 'defecto.jpg'),
(8, 'CON ALCOHOL', 1, 1, 'defecto.jpg'),
(9, 'CAFE TOSTADO MOLIDO', 1, 1, 'defecto.jpg'),
(10, 'POSTRES', 1, 2, 'defecto.jpg'),
(11, 'GUARNICIONES', 0, 2, 'defecto.jpg'),
(12, 'EMBOTELLADOS', 1, 1, 'defecto.jpg'),
(13, 'COCINA', 1, 2, 'defecto.jpg'),
(14, 'PARA PICAR', 1, 2, 'defecto.jpg'),
(15, 'FRAPPES', 1, 1, 'defecto.jpg'),
(16, 'REFRESCANTES ', 1, 1, 'defecto.jpg'),
(17, 'EMBOTELLADAS', 1, 1, 'defecto.jpg'),
(18, 'CAFE A LA OLLA', 1, 2, 'defecto.jpg'),
(19, 'BARRA  ENVIOS', 1, 1, 'defecto.jpg'),
(20, 'COCINA ENVIOS', 1, 2, 'defecto.jpg'),
(21, 'INFUSIONES', 1, 1, 'defecto.jpg'),
(22, 'INFUSION PANDEMIA', 1, 2, 'defecto.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `id` int NOT NULL,
  `dni` char(8) NOT NULL,
  `nombres` varchar(75) NOT NULL,
  `apellido_paterno` varchar(75) NOT NULL,
  `apellido_materno` varchar(75) NOT NULL,
  `sexo` int NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `tele_uno` varchar(25) DEFAULT NULL,
  `tele_dos` varchar(25) DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` int NOT NULL DEFAULT '1',
  `id_tipo_empleado` int NOT NULL,
  `ubicacion` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`id`, `dni`, `nombres`, `apellido_paterno`, `apellido_materno`, `sexo`, `direccion`, `tele_uno`, `tele_dos`, `fecha_registro`, `estado`, `id_tipo_empleado`, `ubicacion`) VALUES
(1, 'admin', 'NOEMI', 'ROSILLO', 'PINZON', 0, '', NULL, NULL, '2019-02-15 10:53:36', 1, 1, 1),
(2, 'mesero1', 'TURNO ', 'MAÑANA', 'X', 1, '', NULL, NULL, '2019-02-15 10:54:20', 1, 2, 1),
(3, 'cajero', 'ELIAN ', 'CAJO', 'CESPEDES', 0, '', '943280165', NULL, '2019-02-15 10:56:05', 1, 3, 1),
(4, 'cocina', 'GLENDA', 'STEFANY', 'GLENDA MESONES', 0, '', NULL, NULL, '2019-02-22 00:44:14', 1, 4, 1),
(5, 'bar', 'SILVIA', 'CALDERON', '   GARCIA', 0, '', NULL, NULL, '2019-02-22 18:51:31', 1, 5, 1),
(6, 'super', 'SAMUEL ANDERSON', 'GONZALES', 'VASQUEZ', 1, 'POMALCA', NULL, NULL, '2019-03-30 13:08:07', 1, 2, 1),
(7, 'mesero2', 'LOCAL', 'PAOLA', 'DIAZ', 0, '', NULL, NULL, '2019-02-22 00:14:26', 1, 2, 2),
(8, '71071386', 'CRISTIAN FERNANDO', 'ROSILLO', 'PINZON', 1, 'MARISCAL CASTILLA 1425', '939418140', NULL, '2022-09-06 08:35:40', 1, 3, 1),
(9, 'mesero3', 'ESMERALDA', 'MENA', 'MEDINA', 0, 'SU CASA', NULL, NULL, '2022-09-28 15:11:31', 1, 2, 3),
(10, 'delivery', 'Delivery', 'Rapido', 'Jaen', 0, '', NULL, NULL, '2022-11-19 10:41:56', 1, 2, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_proceso`
--

CREATE TABLE `estado_proceso` (
  `id` int NOT NULL,
  `toma_pedido` varchar(100) DEFAULT NULL,
  `pedido` varchar(100) DEFAULT NULL,
  `estado_convencional_mesa` varchar(75) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `estado_proceso`
--

INSERT INTO `estado_proceso` (`id`, `toma_pedido`, `pedido`, `estado_convencional_mesa`) VALUES
(1, 'EN ESPERA', 'CONFIRMAR', 'CARRITO VACIO'),
(2, 'RECOGER PEDIDO PARA MESA', 'FINALIZAR', 'CARRITO LLENO'),
(3, 'ENTREGAR PEDIDO PARA MESA', 'ANULAR', NULL),
(4, 'ANULAR EL PEDIDO', NULL, NULL),
(5, NULL, NULL, NULL),
(6, 'PAGADO', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturacion`
--

CREATE TABLE `facturacion` (
  `id` int NOT NULL,
  `id_pedido` int NOT NULL,
  `id_tipo_comprobante` char(2) NOT NULL,
  `numero` int DEFAULT NULL,
  `correlativo` int DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `documento` varchar(11) DEFAULT NULL,
  `razon_social` varchar(255) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `usuario` varchar(100) NOT NULL,
  `monto` decimal(6,2) NOT NULL,
  `puntos` int NOT NULL,
  `estado_puntos` int NOT NULL DEFAULT '1',
  `monto_descuento` decimal(6,2) NOT NULL,
  `monto_amortizacion` decimal(6,2) NOT NULL,
  `ticket` varchar(32) NOT NULL,
  `producto` varchar(100) NOT NULL,
  `cantidad_producto` int NOT NULL,
  `Id_medio_pago` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `facturacion`
--

INSERT INTO `facturacion` (`id`, `id_pedido`, `id_tipo_comprobante`, `numero`, `correlativo`, `fecha_registro`, `documento`, `razon_social`, `direccion`, `usuario`, `monto`, `puntos`, `estado_puntos`, `monto_descuento`, `monto_amortizacion`, `ticket`, `producto`, `cantidad_producto`, `Id_medio_pago`) VALUES
(7, 11, '03', 1, 1, '2022-11-07 16:19:16', '', '', '', 'ELIAN', '23.50', 23, 1, '0.00', '23.50', '', 'HUEVOS DUROSCHOCLITO  FRITO CON QUESO CAPUCCHINO ', 3, 1),
(8, 12, '03', 1, 2, '2022-11-07 16:20:07', '', '', '', 'GORDITA', '42.00', 42, 1, '0.00', '42.00', '', 'SANDWICH QUESO BLANCOSANDWICH DE PAVOLIVIANO SANCOCHADOAMERICANO GRANDE', 5, 1),
(9, 13, '03', 1, 3, '2022-11-07 16:20:29', '', '', '', 'KEIKO', '69.50', 69, 1, '0.00', '69.50', '', 'CEJA DE SELVACAPUCCHINO CHOCOPUCHINO ', 4, 1),
(10, 14, '03', 1, 4, '2022-11-07 16:20:59', '', '', '', 'ERROR', '14.00', 14, 1, '0.00', '14.00', '', 'CAFE A LA OLLA', 2, 1),
(11, 15, '03', 1, 5, '2022-11-07 16:21:41', '', '', '', 'OHHH', '60.00', 60, 1, '0.00', '60.00', '', 'CHICHARRON DE CHANCHOCAPUCCHINO ', 4, 1),
(12, 16, '03', 1, 6, '2022-11-07 16:25:16', '', '', '', 'NARANJA CAMBIO PRECIO', '56.00', 56, 1, '0.00', '56.00', '', 'AMERICANO GRANDENARANJA Y MENTA FRESHESPRESSOBOMBOM', 9, 1),
(13, 17, '03', 1, 7, '2022-11-07 16:25:27', '', '', '', 'SD', '65.00', 65, 1, '0.00', '65.00', '', 'CALDO DE PAICODESAYUNO VEGETARIANONARANJA Y MENTA FRESHCORTADO', 6, 1),
(14, 18, '03', 1, 8, '2022-11-07 16:25:43', '', '', '', 'FD', '14.00', 14, 1, '0.00', '14.00', '', 'CAFE A LA OLLA', 2, 1),
(15, 19, '03', 1, 9, '2022-11-07 16:26:08', '', '', '', 'ERH', '47.00', 47, 1, '0.00', '47.00', '', 'POSTRE DEL DIA CAFE A LA OLLAKEKE DE CHOCOLATEGALLETAS DE CAFE', 8, 1),
(16, 20, '03', 1, 10, '2022-11-07 16:34:32', '', '', '', 'BV', '4.00', 4, 1, '0.00', '4.00', '', 'FANTA', 1, 1),
(17, 22, '03', 1, 11, '2022-11-07 17:05:47', '', '', '', 'UYT', '10.00', 10, 1, '0.00', '10.00', '', 'SANDWICH QUESO BLANCO', 2, 1),
(18, 21, '03', 1, 12, '2022-11-07 17:15:50', '', '', '', 'GALLINERA', '25.00', 25, 1, '0.00', '25.00', '', 'PANQUEQUE DE MANJARNARANJILLA FRESH', 4, 1),
(19, 23, '03', 1, 13, '2022-11-07 17:16:07', '', '', '', 'facturañ- 20487859487', '107.50', 107, 1, '0.00', '107.50', '', 'QUESILLO CON MIELCEJA DE SELVACAFE A LA OLLAV60 KIDSJARRA LIMONADA FRESHBRAWNIEPILSEN ', 9, 1),
(20, 25, '03', 1, 14, '2022-11-07 17:16:55', '', '', '', 'b', '66.00', 66, 1, '0.00', '66.00', '', 'EMPANADA DE QUESO', 6, 1),
(21, 29, '03', 1, 15, '2022-11-07 17:17:03', '', '', '', 'zd', '26.00', 26, 1, '0.00', '26.00', '', 'EMPANADAS DE CHAMPIÑONES', 2, 1),
(22, 28, '03', 1, 16, '2022-11-07 17:17:19', '', '', '', 'h', '19.00', 19, 1, '0.00', '19.00', '', 'SANDWICH DE CHANCHITO', 2, 1),
(23, 26, '03', 1, 17, '2022-11-07 17:18:29', '', '', '', 'safas', '200.00', 200, 1, '0.00', '200.00', '', 'SANDWICH DE PAVOSANDWICH DE PAVO', 20, 1),
(24, 24, '03', 1, 18, '2022-11-07 17:21:27', '', '', '', 'pareja', '108.00', 108, 1, '0.00', '108.00', '', 'EMPANADA DE CARNECHILCANO DE MARACUYAFRAPPE DE NARANJILLANARANJILLA FRESHSANDWICH QUESO SUIZOSANDWIC', 11, 1),
(25, 31, '03', 1, 19, '2022-11-07 17:41:53', '', '', '', 'M', '16.00', 16, 1, '0.00', '16.00', '', 'QUESILLO CON MIELCAFE A LA OLLA', 2, 1),
(26, 30, '03', 1, 20, '2022-11-07 17:44:04', '', '', '', 'Z', '18.00', 18, 1, '0.00', '18.00', '', 'EMPANADA DE QUESOCAFE A LA OLLA', 2, 1),
(27, 33, '03', 1, 21, '2022-11-07 18:33:09', '', '', '', 'señoras', '47.00', 47, 1, '0.00', '47.00', '', 'EMPANADA DE CARNECAFE A LA OLLAEMPANADA DE CARNE', 5, 1),
(28, 32, '03', 1, 22, '2022-11-07 18:33:26', '', '', '', 'chicas', '49.00', 49, 1, '0.00', '49.00', '', 'PANQUEQUE ESPECIALCHOCLITO  FRITO CON QUESO HIERBA LUISA  FRESHMARACUYA FRESHAGUA DE PEPINILLO', 6, 1),
(29, 34, '03', 1, 23, '2022-11-07 18:35:00', '', '', '', 'PARA LLEVAR', '9.00', 9, 1, '0.00', '9.00', '', 'MARACUYA FRESH', 1, 1),
(30, 37, '03', 1, 24, '2022-11-07 18:36:02', '', '', '', 'PAO', '38.00', 38, 1, '0.00', '38.00', '', 'EMPANADA DE QUESOSANDWICH DE PAVOAMERICANO GRANDECAPUCCHINO ', 4, 1),
(31, 39, '03', 1, 25, '2022-11-07 18:55:51', '', '', '', 'señoritas', '41.00', 41, 1, '0.00', '41.00', '', 'PANQUEQUE ESPECIALFRAPPE DE MANGO', 3, 1),
(32, 35, '03', 1, 26, '2022-11-07 18:56:03', '', '', '', 'parejera', '71.00', 71, 1, '0.00', '71.00', '', 'PANQUEQUE DE MANJARSANDWICH DE PAVOTRIPLE TURISTALONCHE SERRANOAMERICANO KIDSCHOCOPUCHINO HIERBA LUI', 7, 1),
(33, 38, '03', 1, 27, '2022-11-07 19:01:29', '', '', '', 'pareja', '59.00', 59, 1, '0.00', '59.00', '', 'TEQUEÑOSCAPUCCHINO INFUSION DE KION MATICO LIMON Y MIELNARANJILLA FRESH', 6, 1),
(34, 36, '03', 1, 28, '2022-11-07 19:05:12', '', '', '', 'PAO', '126.00', 126, 1, '0.00', '126.00', '', 'LIVIANO FRITOGALLINA  CON RECETA TRADICIONAL DE LA ABUELACAFE A LA OLLAAMERICANO GRANDESANDWICH POLL', 11, 1),
(35, 40, '03', 1, 29, '2022-11-07 19:09:02', '', '', '', 'PAOLA}', '32.50', 32, 1, '0.00', '32.50', '', 'TAMALSANDWICH DE PAVOCAPUCCHINO MENTATAMAL', 5, 1),
(36, 45, '03', 1, 30, '2022-11-07 19:23:28', '', '', '', 'PÁO', '87.00', 87, 1, '0.00', '87.00', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELANARANJILLA FRESHMENTAMENTA', 7, 1),
(37, 43, '03', 1, 31, '2022-11-07 19:27:07', '', '', '', 'PAOLA}', '43.50', 43, 1, '0.00', '43.50', '', 'TAMALPANQUEQUE ESPECIALESPRESATEORIANA ', 4, 1),
(38, 41, '03', 1, 32, '2022-11-07 19:29:46', '', '', '', 'señoritas', '24.50', 24, 1, '0.00', '24.50', '', 'QUESILLO CON MIELLIVIANO SANCOCHADOAGUA SAN LUIS SIN GASHIERBA LUISA', 4, 1),
(39, 46, '03', 1, 33, '2022-11-07 19:37:42', '', '', '', 'envio', '18.00', 18, 1, '0.00', '18.00', '', 'QUESILLO CON MIELTAPER BIODEGRADABLE', 4, 1),
(40, 46, '03', 1, 34, '2022-11-07 19:38:01', '', '', '', 'envio', '3.00', 3, 1, '0.00', '3.00', '', 'TAPER BIODEGRADABLE', 2, 1),
(41, 44, '03', 1, 35, '2022-11-07 19:40:25', '', '', '', 'jovenes', '75.50', 75, 1, '0.00', '75.50', '', 'HIERBA LUISA  FRESHNARANJILLA FRESHEMPANADA DE QUESOEMPANADA DE CARNECAFE A LA OLLAORIANA ', 8, 1),
(42, 32, '03', 1, 36, '2022-11-07 19:57:31', '', '', '', 'chicas', '44.00', 44, 1, '0.00', '44.00', '', 'EMPANADA DE QUESO', 4, 1),
(43, 42, '03', 1, 37, '2022-11-07 20:02:09', '', '', '', 'pareja', '34.00', 34, 1, '0.00', '34.00', '', 'SANDWICH DE PAVONARANJILLA FRESH', 4, 1),
(44, 47, '03', 1, 38, '2022-11-07 20:23:24', '', '', '', 'JOKOI', '18.50', 18, 1, '0.00', '18.50', '', 'EMPANADA DE CARNENARANJILLA FRESH', 2, 1),
(45, 50, '03', 1, 39, '2022-11-07 20:37:13', '', '', '', 'BN', '9.00', 9, 1, '0.00', '9.00', '', 'QUESILLO CON MIEL', 1, 1),
(46, 30, '03', 1, 40, '2022-11-07 20:37:23', '', '', '', 'Z', '42.50', 42, 1, '0.00', '42.50', '', 'AMERICANO GRANDESANDWICH DE PAVOAMERICANO GRANDEAMERICANO GRANDE', 5, 1),
(47, 52, '03', 1, 41, '2022-11-07 21:11:04', '', '', '', 'BNJ', '51.50', 51, 1, '0.00', '51.50', '', 'EMPANADA DE QUESOEMPANADA DE CARNECHOCLITO  FRITO CON QUESO FRAPPE DE LUCUMANARANJA Y MENTA FRESH', 5, 1),
(48, 48, '03', 1, 42, '2022-11-07 21:11:20', '', '', '', 'HBJG', '76.00', 76, 1, '0.00', '76.00', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELAAMERICANO GRANDECHOCOLATE', 4, 1),
(49, 26, '03', 1, 43, '2022-11-07 21:11:30', '', '', '', 'safas', '55.00', 55, 1, '0.00', '55.00', '', 'CEJA DE SELVACAPUCCHINO ', 4, 1),
(50, 49, '03', 1, 44, '2022-11-07 21:14:38', '', '', '', 'señores', '26.00', 26, 1, '0.00', '26.00', '', 'EMPANADA DE HUAMBRILLACAFE A LA OLLAAGUA DE PEPINILLO', 3, 1),
(51, 51, '03', 1, 45, '2022-11-07 21:25:13', '', '', '', 'pareja', '29.50', 29, 1, '0.00', '29.50', '', 'LIVIANO FRITOLIVIANO SANCOCHADOAMERICANO GRANDEMANZANILLA', 4, 1),
(52, 53, '03', 1, 46, '2022-11-07 21:37:19', '', '', '', 'pareja', '15.00', 15, 1, '0.00', '15.00', '', 'NARANJA Y MENTA FRESH', 2, 1),
(53, 54, '03', 1, 47, '2022-11-07 22:12:27', '', '', '', 'NHG', '22.50', 22, 1, '0.00', '22.50', '', 'CAPUCCHINO FRAPPE DE NARANJILLA', 2, 1),
(54, 58, '03', 1, 48, '2022-11-08 17:37:07', '', '', '', 'HGVK', '29.50', 29, 1, '0.00', '29.50', '', 'CAPUCCHINO CHOCOPUCHINO KEKE DE CAFEMENTA', 4, 1),
(55, 55, '03', 1, 49, '2022-11-08 17:37:17', '', '', '', ' BBV', '78.00', 78, 1, '0.00', '78.00', '', 'CHILCANO CLASICOMOJITO', 6, 1),
(56, 60, '03', 1, 50, '2022-11-08 17:37:30', '', '', '', 'pareja', '26.00', 26, 1, '0.00', '26.00', '', 'FRESCA FELICIDAD', 2, 1),
(57, 56, '03', 1, 51, '2022-11-08 17:39:05', '', '', '', 'GGFFRFR', '51.00', 51, 1, '0.00', '51.00', '', 'ESPRESATEFRESCA FELICIDAD', 4, 1),
(58, 57, '03', 1, 52, '2022-11-08 17:39:26', '', '', '', 'señores', '28.00', 28, 1, '0.00', '28.00', '', 'HANSEL Y GRETELNARANJILLA FRESH', 3, 1),
(59, 26, '03', 1, 53, '2022-11-08 17:39:38', '', '', '', 'safas', '15.00', 15, 1, '0.00', '15.00', '', 'ESPRESATEMANZANILLA', 2, 1),
(60, 59, '03', 1, 54, '2022-11-08 17:39:49', '', '', '', 'pareja', '24.00', 24, 1, '0.00', '24.00', '', 'CHOCOPUCHINO FRAPPE DE LUCUMA', 2, 1),
(61, 61, '03', 1, 55, '2022-11-08 17:55:05', '', '', '', 'uytiuy', '65.50', 65, 1, '0.00', '65.50', '', 'SANDWICH DE CHANCHITOGALLINA  CON RECETA TRADICIONAL DE LA ABUELACAFE A LA OLLACAPUCCHINO ', 5, 1),
(62, 62, '03', 1, 56, '2022-11-08 18:04:11', '', '', '', 'jjjh', '7.50', 7, 1, '0.00', '7.50', '', 'NARANJILLA FRESH', 1, 1),
(63, 64, '03', 1, 57, '2022-11-08 18:50:28', '', '', '', 'vghgjh', '56.50', 56, 1, '0.00', '56.50', '', 'SANDWICH DE PAVOCAPUCCHINO MACCHIATO', 6, 1),
(64, 67, '03', 1, 58, '2022-11-08 19:11:20', '', '', '', 'ghygfy', '29.50', 29, 1, '0.00', '29.50', '', 'EMPANADA DE QUESOCAPUCCHINO MANZANILLAMANZANILLA', 5, 1),
(65, 65, '03', 1, 59, '2022-11-08 19:18:21', '', '', '', 'señores', '129.50', 129, 1, '0.00', '129.50', '', 'EMPANADAS DE CHAMPIÑONESSANDWICH POLLO CON DURAZNOSANDWICH DE PAVOLATTEEMPANADAS DE CHAMPIÑONESSANDW', 12, 1),
(66, 63, '03', 1, 60, '2022-11-08 19:22:44', '', '', '', 'pareja', '50.50', 50, 1, '0.00', '50.50', '', 'HUMITASANDWICH DE PAVOPIÑA Y HIERBA LUISA FRESHHIERBA LUISAHUMITAPIÑA Y HIERBA LUISA FRESH', 8, 1),
(67, 72, '03', 1, 61, '2022-11-08 19:26:15', '', '', '', 'envio', '30.00', 30, 1, '0.00', '30.00', '', 'SANDWICH DE PAVO', 3, 1),
(68, 68, '03', 1, 62, '2022-11-08 19:34:42', '', '', '', 'pareja', '41.00', 41, 1, '0.00', '41.00', '', 'EMPANADA DE QUESOCAPUCCHINO ', 4, 1),
(69, 26, '03', 1, 63, '2022-11-08 20:04:31', '', '', '', 'safas', '75.00', 75, 1, '0.00', '75.00', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELANARANJILLA FRESH', 4, 1),
(70, 71, '03', 1, 64, '2022-11-08 20:04:42', '', '', '', 'bghhg', '28.50', 28, 1, '0.00', '28.50', '', 'CAPUCCHINO CAPUCCHINO ', 3, 1),
(71, 33, '03', 1, 65, '2022-11-08 20:09:30', '', '', '', 'señoras', '34.00', 34, 1, '0.00', '34.00', '', 'SANDWICH POLLO CON DURAZNOSANDWICH DE PAVONARANJA Y MENTA FRESHPIÑA Y HIERBA LUISA FRESH', 4, 1),
(72, 69, '03', 1, 66, '2022-11-08 20:11:38', '', '', '', 'señores', '51.00', 51, 1, '0.00', '51.00', '', 'EMPANADA DE CARNECAPUCCHINO CHOCOPUCHINO ', 5, 1),
(73, 73, '03', 1, 67, '2022-11-08 20:21:31', '', '', '', 'señores', '94.50', 94, 1, '0.00', '94.50', '', 'PANQUEQUE DE MANJARSANDWICH DE POLLO CLASICOSANDWICH DE CHANCHITOLIVIANO FRITOESPRESATEPIÑA Y HIERBA', 13, 1),
(74, 74, '03', 1, 68, '2022-11-08 20:27:11', '', '', '', 'fdfd', '62.50', 62, 1, '0.00', '62.50', '', 'SANDWICH DE PAVOANDINOPIÑA Y HIERBA LUISA FRESHTEQUEÑOS', 5, 1),
(75, 70, '03', 1, 69, '2022-11-08 20:41:04', '', '', '', 'pareja', '32.00', 32, 1, '0.00', '32.00', '', 'MARACUYA FRESHSANDWICH DE PAVOFRESCA FELICIDAD', 3, 1),
(76, 79, '03', 1, 70, '2022-11-08 20:59:09', '', '', '', 'jovenes', '41.00', 41, 1, '0.00', '41.00', '', 'SANDWICH QUESO BLANCOCAFE A LA OLLACHOCOPUCHINO ', 6, 1),
(77, 78, '03', 1, 71, '2022-11-08 21:08:07', '', '', '', 'pareja', '31.50', 31, 1, '0.00', '31.50', '', 'EMPANADA DE CARNENARANJA Y MENTA FRESHHIERBA LUISASANDWICH DE PAVO', 4, 1),
(78, 76, '03', 1, 72, '2022-11-08 21:13:17', '', '', '', 'hu', '90.00', 90, 1, '0.00', '90.00', '', 'CHICHARRON DE CHANCHOHIERBA LUISA  FRESHPIÑA Y HIERBA LUISA FRESH', 7, 1),
(79, 65, '03', 1, 73, '2022-11-08 21:16:38', '', '', '', 'señores', '193.50', 193, 1, '0.00', '193.50', '', 'TAMALSANDWICH DE PAVOTRIPLE AMERICANOTRIPLE HAWAIANO GALLINA  CON RECETA TRADICIONAL DE LA ABUELALAT', 16, 1),
(80, 75, '03', 1, 74, '2022-11-08 21:43:01', '', '', '', 'pareja', '185.00', 185, 1, '0.00', '185.00', '', 'TINTO DE VERANO EMPANADA DE QUESOTINTO DE VERANO SANDWICH DE PAVOTINTO DE VERANO FRAPPE DE FRESATINT', 13, 1),
(81, 83, '03', 1, 75, '2022-11-08 21:48:25', '', '', '', 'señoras', '39.00', 39, 1, '0.00', '39.00', '', 'SANDWICH POLLO CON DURAZNOCAPUCCHINO ORIANA ', 4, 1),
(82, 84, '03', 1, 76, '2022-11-08 21:49:53', '', '', '', 'gujhgiuj', '41.50', 41, 1, '0.00', '41.50', '', 'CHOCLITO  FRITO CON QUESO ENRROLLADO DE AVENA CON  POLLOHIERBA LUISA  FRESHNARANJILLA FRESHTAMAL', 5, 1),
(83, 80, '03', 1, 77, '2022-11-08 22:18:26', '', '', '', 'señoras', '49.00', 49, 1, '0.00', '49.00', '', 'SANDWICH POLLO CON DURAZNOFRAPPE DE FRESAAGUA SAN LUIS SIN GAS', 5, 1),
(84, 87, '03', 1, 78, '2022-11-08 22:24:20', '', '', '', 'willy', '5.00', 5, 1, '0.00', '5.00', '', 'COCA COLA', 1, 1),
(85, 77, '03', 1, 79, '2022-11-08 22:29:16', '', '', '', 'jhjkj', '64.00', 64, 1, '0.00', '64.00', '', 'AGUA DE PEPINILLOSANDWICH POLLO CON DURAZNOSANDWICH DE PAVOCAFE A LA OLLAAGUA SAN LUIS CON GASMANZAN', 11, 1),
(86, 85, '03', 1, 80, '2022-11-08 22:37:23', '', '', '', 'chicos', '71.00', 71, 1, '0.00', '71.00', '', 'TEQUEÑOSANDINO', 4, 1),
(87, 82, '03', 1, 81, '2022-11-08 22:41:10', '', '', '', 'chicas', '100.00', 100, 1, '0.00', '100.00', '', 'FRAPPE DE MANGOEMPANADA DE QUESOFRAPPE DE MANGOCUBA LIBREEMPANADA DE QUESOCUBA LIBREFRAPPE DE MANGO', 8, 1),
(88, 86, '03', 1, 82, '2022-11-08 22:41:36', '', '', '', 'silvia', '8.50', 8, 1, '0.00', '8.50', '', 'CUSQUEÑA DOBLE MALTA', 1, 1),
(89, 81, '03', 1, 83, '2022-11-08 22:46:01', '', '', '', 'jovenes', '60.00', 60, 1, '0.00', '60.00', '', 'PISCO SOURPISCO SOUR', 4, 1),
(90, 89, '03', 1, 84, '2022-11-09 19:33:20', '', '', '', 'hhg', '132.00', 132, 1, '0.00', '132.00', '', 'SANDWICH DE PAVOCHICHARRON DE CHANCHOCAPUCCHINO FRESCA FELICIDADPIÑA Y HIERBA LUISA FRESHKEKE DE CAF', 12, 1),
(91, 88, '03', 1, 85, '2022-11-09 20:13:27', '', '', '', 'señoras', '70.00', 70, 1, '0.00', '70.00', '', 'SANDWICH DE CHANCHITOMARACUYA FRESHAMERICANO GRANDEKEKE DE CAFEMOJITOKEKE DE CAFEAGUA SAN LUIS SIN G', 8, 1),
(92, 90, '03', 1, 86, '2022-11-09 20:30:35', '', '', '', 'pareja', '19.00', 19, 1, '0.00', '19.00', '', 'CAPUCCHINO ', 2, 1),
(93, 97, '03', 1, 87, '2022-11-09 20:43:49', '', '', '', 'señores', '126.50', 126, 1, '0.00', '126.50', '', 'CHICHARRON DE CHANCHOGALLINA  CON RECETA TRADICIONAL DE LA ABUELAFRAPPE DE LUCUMAHIERBA LUISA  FRESH', 10, 1),
(94, 92, '03', 1, 88, '2022-11-09 20:44:17', '', '', '', 'jovenes', '72.50', 72, 1, '0.00', '72.50', '', 'SANDWICH QUESO SUIZOSANDWICH DE PAVOCAPUCCHINO TEQUEÑOS', 7, 1),
(95, 91, '03', 1, 89, '2022-11-09 21:13:03', '', '', '', 'pareja', '66.00', 66, 1, '0.00', '66.00', '', 'SANDWICH DE PAVOCAPUCCHINO LIMON Y HIERBA BUENAPISCO SOUR', 6, 1),
(96, 96, '03', 1, 90, '2022-11-09 21:15:50', '', '', '', 'jovenes', '94.00', 94, 1, '0.00', '94.00', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELANARANJILLA FRESHSANDWICH DE PAVOMARACUYA FRESH', 6, 1),
(97, 98, '03', 1, 91, '2022-11-09 21:28:01', '', '', '', 'pareja', '16.50', 16, 1, '0.00', '16.50', '', 'PIÑA Y HIERBA LUISA FRESHMARACUYA FRESH', 2, 1),
(98, 102, '03', 1, 92, '2022-11-09 21:33:46', '', '', '', 'pana', '13.00', 13, 1, '0.00', '13.00', '', 'FRAPPE DE MANGO', 1, 1),
(99, 100, '03', 1, 93, '2022-11-09 21:56:15', '', '', '', 'mmmm', '36.00', 36, 1, '0.00', '36.00', '', 'EMPANADA DE QUESOESPRESATEFRAPPE DE MANGO', 3, 1),
(100, 26, '03', 1, 94, '2022-11-09 22:13:29', '', '', '', 'safas', '31.50', 31, 1, '0.00', '31.50', '', 'SANDWICH DE PAVOCHOCOPUCHINO ORIANA ', 3, 1),
(101, 101, '03', 1, 95, '2022-11-09 22:19:11', '', '', '', 'kkk', '76.50', 76, 1, '0.00', '76.50', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELAAMERICANO GRANDEMARACUYA FRESH', 4, 1),
(102, 99, '03', 1, 96, '2022-11-09 22:46:24', '', '', '', 'chicos', '191.00', 191, 1, '0.00', '191.00', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELAORIANA NARANJILLA FRESHMAJOTENARANJILLA FRESHGALLINA  CO', 10, 1),
(103, 103, '03', 1, 97, '2022-11-09 22:46:36', '', '', '', 'kkk', '96.00', 96, 1, '0.00', '96.00', '', 'EMPANADA DE QUESOCHILCANO CLASICOEMPANADA DE CARNECHILCANO CLASICO', 8, 1),
(104, 65, '03', 1, 98, '2022-11-09 22:49:45', '', '', '', 'señores', '47.00', 47, 1, '0.00', '47.00', '', 'TRIPLE AMERICANOANDINO', 3, 1),
(105, 95, '03', 1, 99, '2022-11-09 22:57:27', '', '', '', 'ggg', '11.50', 11, 1, '0.00', '11.50', '', 'ORIANA ', 1, 1),
(106, 93, '03', 1, 100, '2022-11-09 22:57:42', '', '', '', 'hbvhg', '16.00', 16, 1, '0.00', '16.00', '', 'EMPANADA DE CARNEINKA KOLA', 2, 1),
(107, 94, '03', 1, 101, '2022-11-09 22:58:27', '', '', '', ' bb', '16.50', 16, 1, '0.00', '16.50', '', 'CAPUCCHINO KEKE DE CAFE', 2, 1),
(108, 104, '03', 1, 102, '2022-11-09 22:58:39', '', '', '', 'jj', '47.00', 47, 1, '0.00', '47.00', '', 'EMPANADA DE HUAMBRILLAPIÑA Y HIERBA LUISA FRESH', 4, 1),
(109, 105, '03', 1, 103, '2022-11-10 17:45:40', '', '', '', 'ELIAN', '13.00', 13, 1, '0.00', '13.00', '', 'FRAPPE DE MANGO', 1, 1),
(110, 107, '03', 1, 104, '2022-11-10 18:26:18', '', '', '', 'tyyy', '46.50', 46, 1, '0.00', '46.50', '', 'PANQUEQUE ESPECIALSANDWICH POLLO CON DURAZNOCAPUCCHINO HANSEL Y GRETEL', 4, 1),
(111, 65, '03', 1, 105, '2022-11-10 19:04:17', '', '', '', 'señores', '84.00', 84, 1, '0.00', '84.00', '', 'LONCHE SERRANOGALLINA  CON RECETA TRADICIONAL DE LA ABUELACAPUCCHINO KEKE DE CAFENARANJILLA FRESHMAR', 6, 1),
(112, 108, '03', 1, 106, '2022-11-10 19:04:31', '', '', '', 'ENVIO', '24.00', 24, 1, '0.00', '24.00', '', 'SANDWICH DE PAVOHANSEL Y GRETELVASO DOMO', 3, 1),
(113, 106, '03', 1, 107, '2022-11-10 19:04:51', '', '', '', 'ccccccccccccccccff', '40.50', 40, 1, '0.00', '40.50', '', 'TEQUEÑOSCAPUCCHINO FRAPPE DE LUCUMA', 3, 1),
(114, 115, '03', 1, 108, '2022-11-10 19:27:05', '', '', '', 'ñññ', '50.50', 50, 1, '0.00', '50.50', '', 'SANDWICH POLLO CON DURAZNOTRIPLE TURISTAESPRESATESANDWICH QUESO BLANCOCAPUCCHINO ', 5, 1),
(115, 116, '03', 1, 109, '2022-11-10 19:32:40', '', '', '', 'tt', '13.00', 13, 1, '0.00', '13.00', '', 'HANSEL Y GRETEL', 1, 1),
(116, 114, '03', 1, 110, '2022-11-10 19:37:23', '', '', '', 'eee', '41.50', 41, 1, '0.00', '41.50', '', 'TEQUEÑOSCAPUCCHINO AGUA SAN LUIS SIN GASESPRESATE', 4, 1),
(117, 111, '03', 1, 111, '2022-11-10 19:43:34', '', '', '', 'cvcc', '73.50', 73, 1, '0.00', '73.50', '', 'QUESILLO CON MIELEMPANADA DE QUESOSANDWICH DE POLLO CLASICOESPRESATEORIANA ', 7, 1),
(118, 112, '03', 1, 112, '2022-11-10 19:48:59', '', '', '', 'ggg', '31.00', 31, 1, '0.00', '31.00', '', 'HUMITASANDWICH POLLO CON DURAZNOCAPUCCHINO NARANJILLA FRESH', 4, 1),
(119, 117, '03', 1, 113, '2022-11-10 19:50:44', '', '', '', 'fgffrr', '40.00', 40, 1, '0.00', '40.00', '', 'EMPANADA DE QUESOEMPANADA DE HUAMBRILLALIMON Y HIERBA BUENA', 4, 1),
(120, 74, '03', 1, 114, '2022-11-10 19:57:28', '', '', '', 'fdfd', '41.50', 41, 1, '0.00', '41.50', '', 'CEJA DE SELVAAMERICANO GRANDECHEMEX KIDS', 3, 1),
(121, 118, '03', 1, 115, '2022-11-10 19:58:18', '', '', '', 'kmkk', '21.50', 21, 1, '0.00', '21.50', '', 'EMPANADA DE CARNEAGUA DE PEPINILLONARANJA Y MENTA FRESH', 3, 1),
(122, 109, '03', 1, 116, '2022-11-10 19:58:27', '', '', '', 'chicas', '70.50', 70, 1, '0.00', '70.50', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELAAMERICANO GRANDEMANZANILLA', 4, 1),
(123, 75, '03', 1, 117, '2022-11-10 20:08:49', '', '', '', 'pareja', '29.50', 29, 1, '0.00', '29.50', '', 'HUMITASANDWICH DE CHANCHITOAMERICANO GRANDE', 4, 1),
(124, 119, '03', 1, 118, '2022-11-10 20:14:57', '', '', '', 'gg', '27.00', 27, 1, '0.00', '27.00', '', 'EMPANADA DE QUESOCAPUCCHINO LIMON Y HIERBA BUENA', 3, 1),
(125, 120, '03', 1, 119, '2022-11-10 20:26:08', '', '', '', 'llll', '41.00', 41, 1, '0.00', '41.00', '', 'SANDWICH QUESO SUIZOTRIPLE HAWAIANO CAPUCCHINO ORIANA ', 4, 1),
(126, 124, '03', 1, 120, '2022-11-10 20:53:11', '', '', '', 'kkk', '29.00', 29, 1, '0.00', '29.00', '', 'SANDWICH DE PAVOMANZANILLAHIERBA LUISA', 5, 1),
(127, 65, '03', 1, 121, '2022-11-10 20:57:25', '', '', '', 'señores', '50.00', 50, 1, '0.00', '50.00', '', 'EMPANADA DE QUESOSANDWICH DE PAVOCAFE A LA OLLAPIÑA Y HIERBA LUISA FRESHPIÑA Y HIERBA LUISA FRESH', 6, 1),
(128, 122, '03', 1, 122, '2022-11-10 20:57:36', '', '', '', 'ppp', '59.50', 59, 1, '0.00', '59.50', '', 'CHOCLITO  FRITO CON QUESO TEQUEÑOSORIANA FRAPPE DE FRESAMARACUYA FRESH', 5, 1),
(129, 123, '03', 1, 123, '2022-11-10 21:10:23', '', '', '', 'hhhh', '31.50', 31, 1, '0.00', '31.50', '', 'EMPANADA DE CARNEFRAPPE DE MANGONARANJILLA FRESH', 3, 1),
(130, 127, '03', 1, 124, '2022-11-10 21:13:07', '', '', '', '4r55', '14.00', 14, 1, '0.00', '14.00', '', 'CAFE A LA OLLA', 2, 1),
(131, 125, '03', 1, 125, '2022-11-10 21:21:11', '', '', '', 'ggg', '47.00', 47, 1, '0.00', '47.00', '', 'EMPANADA DE HUAMBRILLASANDWICH DE CHANCHITOCHOCOLATEFRESCA FELICIDAD', 4, 1),
(132, 113, '03', 1, 126, '2022-11-10 21:21:50', '', '', '', 'señoras', '104.00', 104, 1, '0.00', '104.00', '', 'CHICHARRON DE CHANCHOCHILCANO DE MARACUYANARANJILLA FRESHQUESILLO CON MIEL', 7, 1),
(133, 129, '03', 1, 127, '2022-11-10 21:26:57', '', '', '', 't66t', '80.00', 80, 1, '0.00', '80.00', '', 'EMPANADA DE QUESOCALDO DE PAICOFRAPPE DE LUCUMAROMPOPE', 7, 1),
(134, 26, '03', 1, 128, '2022-11-10 21:29:15', '', '', '', 'safas', '34.00', 34, 1, '0.00', '34.00', '', 'SANDWICH DE PAVOCAFE A LA OLLA', 4, 1),
(135, 130, '03', 1, 129, '2022-11-10 21:30:05', '', '', '', 'orfelinda', '14.00', 14, 1, '0.00', '14.00', '', 'FRAPPE DE FRESA', 1, 1),
(136, 126, '03', 1, 130, '2022-11-10 21:31:18', '', '', '', 'jj', '55.50', 55, 1, '0.00', '55.50', '', 'CEJA DE SELVACHICHARRON DE CHANCHOCAFE A LA OLLACHOCOPUCHINO ', 4, 1),
(137, 121, '03', 1, 131, '2022-11-10 21:45:40', '', '', '', 'kkk', '87.00', 87, 1, '0.00', '87.00', '', 'EMPANADA DE QUESOCUBA LIBREHUMITAMOJITOAGUA SAN LUIS SIN GAS', 9, 1),
(138, 128, '03', 1, 132, '2022-11-10 21:51:43', '', '', '', 'ww', '23.00', 23, 1, '0.00', '23.00', '', 'ORIANA ', 2, 1),
(139, 131, '03', 1, 133, '2022-11-10 22:02:23', '', '', '', 'll', '82.00', 82, 1, '0.00', '82.00', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELACAFE A LA OLLANARANJILLA FRESHPIÑA Y HIERBA LUISA FRESH', 5, 1),
(140, 134, '03', 1, 134, '2022-11-10 22:09:09', '', '', '', 'jj', '19.50', 19, 1, '0.00', '19.50', '', 'BOMBOMORIANA ', 2, 1),
(141, 133, '03', 1, 135, '2022-11-10 22:14:00', '', '', '', 'hhhhh', '22.50', 22, 1, '0.00', '22.50', '', 'SANDWICH DE PAVOCAPUCCHINO MENTA', 3, 1),
(142, 135, '03', 1, 136, '2022-11-10 22:33:41', '', '', '', 'll', '40.00', 40, 1, '0.00', '40.00', '', 'SANDWICH DE PAVOCHOCOPUCHINO ', 4, 1),
(143, 137, '03', 1, 137, '2022-11-10 22:43:39', '', '', '', 'gg', '47.00', 47, 1, '0.00', '47.00', '', 'EMPANADA DE QUESOEMPANADA DE CARNESANDWICH DE CHANCHITOCAFE A LA OLLACHOCOLATE', 5, 1),
(144, 132, '03', 1, 138, '2022-11-10 22:45:43', '', '', '', 'ññ', '15.50', 15, 1, '0.00', '15.50', '', 'CAPUCCHINO MANZANILLAMANZANILLA', 3, 1),
(145, 26, '03', 1, 139, '2022-11-10 22:49:40', '', '', '', 'safas', '58.00', 58, 1, '0.00', '58.00', '', 'CUBA LIBREBARBARIAN LIMA PALE ALEBARBARIAN LA NENA', 4, 1),
(146, 136, '03', 1, 140, '2022-11-10 22:49:50', '', '', '', 'hhh', '41.50', 41, 1, '0.00', '41.50', '', 'EMPANADA DE QUESOCAPUCCHINO CHOCOPUCHINO EMPANADA DE CARNE', 4, 1),
(147, 127, '03', 1, 141, '2022-11-10 22:50:04', '', '', '', '4r55', '95.00', 95, 1, '0.00', '95.00', '', 'SANDWICH DE CHANCHITOCEJA DE SELVALONCHE SERRANOAMERICANO KIDSCAPUCCHINO FRAPPE DE LUCUMAFRAPPE DE F', 7, 1),
(148, 110, '03', 1, 142, '2022-11-10 23:00:22', '', '', '', 'lllll', '267.00', 267, 1, '0.00', '267.00', '', 'HUMITAEMPANADAS DE CHAMPIÑONESCAPUCCHINO AGUA DE PEPINILLONARANJILLA FRESHEMPANADAS DE CHAMPIÑONESAR', 20, 1),
(149, 138, '03', 1, 143, '2022-11-11 18:39:01', '', '', '', 'vvv', '33.50', 33, 1, '0.00', '33.50', '', 'SANDWICH DE PAVOCAPUCCHINO FRAPPE DE FRESA', 3, 1),
(150, 139, '03', 1, 144, '2022-11-11 19:46:40', '', '', '', 'bbbb', '12.50', 12, 1, '0.00', '12.50', '', 'ORIANA VASO DOMO', 2, 1),
(151, 142, '03', 1, 145, '2022-11-11 20:18:48', '', '', '', 'lll', '51.00', 51, 1, '0.00', '51.00', '', 'EMPANADA DE QUESOHANSEL Y GRETELFRAPPE DE MANGOFRAPPE DE FRESA', 4, 1),
(152, 140, '03', 1, 146, '2022-11-11 20:32:44', '', '', '', 'ggg', '44.00', 44, 1, '0.00', '44.00', '', 'SANDWICH DE PAVOESPRESATE', 4, 1),
(153, 144, '03', 1, 147, '2022-11-11 20:46:29', '', '', '', '56', '65.50', 65, 1, '0.00', '65.50', '', 'EMPANADA DE CARNETEQUEÑOSCOCTEL DE ALGARROBINAORIANA CHIBOLO POWER', 5, 1),
(154, 145, '03', 1, 148, '2022-11-11 20:52:03', '', '', '', 'hh', '56.50', 56, 1, '0.00', '56.50', '', 'CHOCLITO  FRITO CON QUESO GALLINA  CON RECETA TRADICIONAL DE LA ABUELACAPUCCHINO MANZANILLAHUEVOS DU', 5, 1),
(155, 143, '03', 1, 149, '2022-11-11 20:54:31', '', '', '', 'ENVIO', '48.00', 48, 1, '0.00', '48.00', '', 'EMPANADA DE QUESOCAJA BIODEGRADABLE', 8, 1),
(156, 147, '03', 1, 150, '2022-11-11 20:56:39', '', '', '', 'DEISY', '6.00', 6, 1, '0.00', '6.00', '', 'PANQUEQUE DE MANJAR', 1, 1),
(157, 65, '03', 1, 151, '2022-11-11 21:16:50', '', '', '', 'señores', '158.50', 158, 1, '0.00', '158.50', '', 'LIMON Y HIERBA BUENACAPUCCHINO CHOCOPUCHINO CHICHARRON DE CHANCHOCHICHARRON DE CHANCHONARANJILLA FRE', 14, 1),
(158, 146, '03', 1, 152, '2022-11-11 21:23:41', '', '', '', 'tgtt', '17.00', 17, 1, '0.00', '17.00', '', 'CAPUCCHINO NARANJILLA FRESH', 2, 1),
(159, 150, '03', 1, 153, '2022-11-11 21:59:54', '', '', '', 'ss', '40.00', 40, 1, '0.00', '40.00', '', 'CHICHARRON DE CHANCHOESPRESATENARANJILLA FRESH', 3, 1),
(160, 141, '03', 1, 154, '2022-11-11 22:02:06', '', '', '', 'tttt', '179.50', 179, 1, '0.00', '179.50', '', 'EMPANADA DE HUAMBRILLACHICHARRON DE CHANCHOTEQUEÑOSAGUA SAN LUIS SIN GASHIERBA LUISA  FRESHNARANJILL', 14, 1),
(161, 149, '03', 1, 155, '2022-11-11 22:03:57', '', '', '', 'ÑÑÑ', '7.50', 7, 1, '0.00', '7.50', '', 'SANDWICH DE POLLO CLASICO', 1, 1),
(162, 153, '03', 1, 156, '2022-11-11 22:06:30', '', '', '', 'kkk', '42.00', 42, 1, '0.00', '42.00', '', 'FRAPPE DE MANGOGELATO', 3, 1),
(163, 152, '03', 1, 157, '2022-11-11 22:14:31', '', '', '', 'jjj', '58.00', 58, 1, '0.00', '58.00', '', 'EMPANADA DE CARNESANDWICH DE PAVOCHICHARRON DE CHANCHOCAFE A LA OLLACAPUCCHINO ', 5, 1),
(164, 148, '03', 1, 158, '2022-11-11 22:16:28', '', '', '', 'ññññ', '74.00', 74, 1, '0.00', '74.00', '', 'CHILCANO DE NARANJILLACHILCANO DE MARACUYATEQUEÑOSMOJITOSARZA', 6, 1),
(165, 151, '03', 1, 159, '2022-11-12 17:58:04', '', '', '', 'kkk', '50.00', 50, 1, '0.00', '50.00', '', 'CHOCLITO  FRITO CON QUESO FRAPPE DE FRUTOS SECOS', 4, 1),
(166, 154, '03', 1, 160, '2022-11-12 18:01:50', '', '', '', 'kkk', '14.50', 14, 1, '0.00', '14.50', '', 'AGUA SAN LUIS SIN GASORIANA ', 2, 1),
(167, 158, '03', 1, 161, '2022-11-12 19:10:33', '', '', '', 'trtrr', '40.50', 40, 1, '0.00', '40.50', '', 'HUMITASANDWICH DE PAVOCAPUCCHINO KIDSMANZANILLA', 6, 1),
(168, 160, '03', 1, 162, '2022-11-12 19:34:46', '71071386', 'CRISTIAN FERNANDO ROSILLO PINZON', '', 'ttt', '30.00', 30, 1, '0.00', '30.00', '', 'SANDWICH DE POLLO CLASICOCAPUCCHINO FRESCA FELICIDAD', 3, 1),
(169, 156, '03', 1, 163, '2022-11-12 20:05:00', '71071386', 'CRISTIAN FERNANDO ROSILLO PINZON', '', 'ñññ', '32.00', 32, 1, '0.00', '32.00', '', 'CUZQUEÑA TRIGO CUZQUEÑA TRIGO ', 4, 1),
(170, 157, '03', 1, 164, '2022-11-12 20:14:29', '71071386', 'CRISTIAN FERNANDO ROSILLO PINZON', '', 'll', '97.50', 97, 1, '0.00', '97.50', '', 'AGUA SAN LUIS SIN GASEMPANADA DE QUESOEMPANADA DE CARNECAPUCCHINO MOJITOCHILCANO DE NARANJILLA', 9, 1),
(171, 161, '03', 1, 165, '2022-11-12 20:14:50', '71071386', 'CRISTIAN FERNANDO ROSILLO PINZON', '', 'll', '19.50', 19, 1, '0.00', '19.50', '', 'CAPUCCHINO CHOCOPUCHINO ', 2, 1),
(172, 164, '03', 1, 166, '2022-11-12 20:20:45', '71071386', 'CRISTIAN FERNANDO ROSILLO PINZON', '', 'ñññ', '34.50', 34, 1, '0.00', '34.50', '', 'TAMALNARANJILLA FRESHTRIPLE TURISTACAFE A LA OLLA', 4, 1),
(173, 162, '03', 1, 167, '2022-11-12 20:25:45', '71071386', 'CRISTIAN FERNANDO ROSILLO PINZON', '', 'ttt', '93.00', 93, 1, '0.00', '93.00', '', 'PANQUEQUE DE MANJAREMPANADA DE QUESOSANDWICH POLLO CON DURAZNOSANDWICH DE PAVOCAPUCCHINO CHOCOPUCHIN', 10, 1),
(174, 155, '03', 1, 168, '2022-11-12 20:26:23', '71071386', 'CRISTIAN FERNANDO ROSILLO PINZON', '', 'lll', '0.00', 0, 1, '0.00', '0.00', '', 'ORIANA ', 1, 1),
(175, 165, '03', 1, 169, '2022-11-12 20:41:39', '71071386', 'CRISTIAN FERNANDO ROSILLO PINZON', '', 'mesa 4', '41.50', 41, 1, '0.00', '41.50', '', 'TEQUEÑOSORIANA FRAPPE DE MANGO', 3, 1),
(176, 159, '03', 1, 170, '2022-11-12 20:55:37', '71071383', 'JHON FRAN IRIGOIN CARRERO', '', 'ryt6ujyt', '63.00', 63, 1, '0.00', '63.00', '', 'EMPANADA DE QUESOEMPANADAS DE CHAMPIÑONESCAFE A LA OLLACAFE A LA OLLA', 7, 1),
(177, 167, '03', 1, 171, '2022-11-12 21:03:04', '71071368', 'IRIS YOJANI QUISPE JARA', '', 'll', '76.00', 76, 1, '0.00', '76.00', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELAAMERICANO GRANDECHOCOLATE', 4, 1),
(178, 168, '03', 1, 172, '2022-11-12 21:05:56', '71071386', 'CRISTIAN FERNANDO ROSILLO PINZON', '', 'fytred', '31.00', 31, 1, '0.00', '31.00', '', 'PANQUEQUE DE MANJARESPRESATEFRAPPE DE BERENJENA', 3, 1),
(179, 166, '03', 1, 173, '2022-11-12 21:06:32', '71071386', 'CRISTIAN FERNANDO ROSILLO PINZON', '', 'hgf', '90.00', 90, 1, '0.00', '90.00', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELAFRAPPE DE NARANJILLAFRAPPE DE LUCUMAAGUA SAN LUIS SIN GA', 5, 1),
(180, 163, '03', 1, 174, '2022-11-12 21:38:38', '71071386', 'CRISTIAN FERNANDO ROSILLO PINZON', '', 'hhh', '71.00', 71, 1, '0.00', '71.00', '', 'TEQUEÑOSCAPUCCHINO PANQUEQUE DE MANJARCHILCANO DE NARANJILLABARBARIAN LA NENA', 6, 1),
(181, 170, '01', 1, 1, '2022-11-12 21:50:23', '10409267969', 'OCHOA CHINGUEL TRINIDAD', '', 'kkk', '141.00', 141, 1, '0.00', '141.00', '', 'PANQUEQUE ESPECIALSANDWICH DE POLLO CLASICOGALLINA  CON RECETA TRADICIONAL DE LA ABUELACAFE A LA OLL', 10, 1),
(182, 172, '03', 1, 175, '2022-11-12 21:57:20', '71071386', 'CRISTIAN FERNANDO ROSILLO PINZON', '', 'jjj', '76.50', 76, 1, '0.00', '76.50', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELANARANJA Y MENTA FRESHCHIBOLO POWER', 4, 1),
(183, 169, '03', 1, 176, '2022-11-12 22:11:07', '71071386', 'CRISTIAN FERNANDO ROSILLO PINZON', '', 'lll', '194.50', 194, 1, '0.00', '194.50', '', 'HUMITASANDWICH DE PAVOCHOCOLATEMOJITONARANJILLA FRESH', 19, 1),
(184, 173, '03', 1, 177, '2022-11-12 22:29:19', '71071386', 'CRISTIAN FERNANDO ROSILLO PINZON', '', 'ññ', '27.00', 27, 1, '0.00', '27.00', '', 'SANDWICH DE PAVOCAPUCCHINO NARANJILLA FRESH', 3, 1),
(185, 155, '01', 1, 2, '2022-11-12 22:30:55', '10409267969', 'OCHOA CHINGUEL TRINIDAD', '', 'lll', '11.50', 11, 1, '0.00', '11.50', '', 'ORIANA ', 1, 1),
(186, 26, '03', 1, 178, '2022-11-12 22:36:26', '71071386', 'CRISTIAN FERNANDO ROSILLO PINZON', '', 'safas', '69.00', 69, 1, '0.00', '69.00', '', 'TEQUEÑOSMOJITOMOJITO', 5, 1),
(187, 174, '03', 1, 179, '2022-11-13 17:24:50', '', '', '', 'ddgfhgf', '23.00', 23, 1, '0.00', '23.00', '', 'ORIANA ', 2, 1),
(188, 175, '03', 1, 180, '2022-11-13 17:39:18', '', '', '', 'pasooooo', '7.00', 7, 1, '0.00', '7.00', '', 'PILSEN ', 1, 1),
(189, 176, '03', 1, 181, '2022-11-13 18:16:12', '', '', '', 'jjoiiuj', '39.00', 39, 1, '0.00', '39.00', '', 'EMPANADA DE CARNEMOJITOPISCO SOUR', 3, 1),
(190, 177, '03', 1, 182, '2022-11-13 19:15:32', '', '', '', 'jhfcdfhg', '34.00', 34, 1, '0.00', '34.00', '', 'SANDWICH DE PAVOCAFE A LA OLLA', 4, 1),
(191, 178, '03', 1, 183, '2022-11-13 19:22:00', '', '', '', 'i8ioio', '20.00', 20, 1, '0.00', '20.00', '', 'CHOCOPUCHINO ', 2, 1),
(192, 179, '03', 1, 184, '2022-11-13 19:56:36', '', '', '', 'ytytuyt', '75.50', 75, 1, '0.00', '75.50', '', 'SANDWICH DE PAVOCHILCANO DE NARANJILLAMOJITONARANJILLA FRESHTINTO DE VERANO COCTEL DE ALGARROBINA', 6, 1),
(193, 181, '03', 1, 185, '2022-11-13 19:56:46', '', '', '', 'gttt', '54.00', 54, 1, '0.00', '54.00', '', 'MAJOTECHICHARRON DE CHANCHOAGUA SAN LUIS SIN GASAGUA DE PEPINILLO', 5, 1),
(194, 185, '03', 1, 186, '2022-11-13 20:17:48', '', '', '', 'ttrtrtra', '163.00', 163, 1, '0.00', '163.00', '', 'HUMITATAMALEMPANADA DE QUESOSANDWICH QUESO BLANCOCALDO DE PAICOLIVIANO FRITOCEJA DE SELVAGALLINA  CO', 17, 1),
(195, 188, '03', 1, 187, '2022-11-13 20:23:24', '', '', '', 'FESHG', '12.50', 12, 1, '0.00', '12.50', '', 'EMPANADA DE QUESOTAPER BIODEGRADABLE', 2, 1),
(196, 186, '03', 1, 188, '2022-11-13 20:25:41', '', '', '', '666', '82.50', 82, 1, '0.00', '82.50', '', 'EMPANADA DE QUESOEMPANADA DE CARNETRIPLE HAWAIANO AMERICANO GRANDECAPUCCHINO CHOCOPUCHINO KIDSORIANA', 8, 1),
(197, 183, '03', 1, 189, '2022-11-13 20:30:20', '', '', '', 'u', '65.00', 65, 1, '0.00', '65.00', '', 'CHICHARRON DE CHANCHOESPRESATECHICHARRON DE CHANCHOESPRESATE', 4, 1),
(198, 180, '03', 1, 190, '2022-11-13 20:45:25', '', '', '', 'ioooo', '56.00', 56, 1, '0.00', '56.00', '', 'CAPUCCHINO PIÑA Y HIERBA LUISA FRESHEMPANADA DE QUESOCAPUCCHINO PIÑA Y HIERBA LUISA FRESH', 6, 1),
(199, 187, '03', 1, 191, '2022-11-13 21:05:26', '', '', '', 'gg', '37.50', 37, 1, '0.00', '37.50', '', 'EMPANADA DE QUESOANISTEQUEÑOSLIMON Y HIERBA BUENA', 4, 1),
(200, 26, '03', 1, 192, '2022-11-13 21:06:20', '', '', '', 'safas', '14.00', 14, 1, '0.00', '14.00', '', 'AGUARDIENTE', 2, 1),
(201, 190, '03', 1, 193, '2022-11-13 21:27:42', '', '', '', 'ggfdgfd', '52.00', 52, 1, '0.00', '52.00', '', 'EMPANADA DE QUESOEMPANADA DE CARNEINFUSION DE PEREJIL MAS LIMONINFUSION DE EUCALIPTO MAS LIMON Y MIE', 6, 1),
(202, 191, '03', 1, 194, '2022-11-13 21:28:38', '', '', '', 'gft', '21.00', 21, 1, '0.00', '21.00', '', 'EMPANADA DE QUESOCHOCOPUCHINO ', 2, 1),
(203, 189, '03', 1, 195, '2022-11-13 21:35:28', '', '', '', 'uuu', '27.00', 27, 1, '0.00', '27.00', '', 'FRAPPE DE MANGOFRAPPE DE LUCUMA', 2, 1),
(204, 182, '03', 1, 196, '2022-11-13 21:35:50', '', '', '', 'jhyyuyr', '29.00', 29, 1, '0.00', '29.00', '', 'HUMITATAMALCAPUCCHINO ', 4, 1),
(205, 192, '03', 1, 197, '2022-11-13 21:36:59', '', '', '', 'tew5', '51.50', 51, 1, '0.00', '51.50', '', 'CHILCANO DE MANGOESPRESATETAPER BIODEGRADABLE', 5, 1),
(206, 194, '03', 1, 198, '2022-11-13 22:03:44', '', '', '', 'gfdsgfds', '26.00', 26, 1, '0.00', '26.00', '', 'PANQUEQUE DE MANJARV60', 2, 1),
(207, 26, '03', 1, 199, '2022-11-13 22:17:27', '', '', '', 'safas', '26.00', 26, 1, '0.00', '26.00', '', 'NARANJILLA FRESHNARANJA Y MENTA FRESHEMPANADA DE QUESO', 3, 1),
(208, 196, '03', 1, 200, '2022-11-13 22:21:32', '', '', '', 'yy', '40.00', 40, 1, '0.00', '40.00', '', 'GELATOHANSEL Y GRETELEMPANADA DE QUESO', 3, 1),
(209, 195, '03', 1, 201, '2022-11-13 22:23:23', '', '', '', 'ggfra', '31.50', 31, 1, '0.00', '31.50', '', 'SANDWICH DE POLLO CLASICOESPRESATE', 3, 1),
(210, 193, '03', 1, 202, '2022-11-13 22:28:21', '', '', '', 'mmbmn', '16.50', 16, 1, '0.00', '16.50', '', 'SANDWICH QUESO SUIZOCAPUCCHINO ', 2, 1),
(211, 197, '03', 1, 203, '2022-11-13 22:48:20', '', '', '', 'hhyh', '45.50', 45, 1, '0.00', '45.50', '', 'EMPANADA DE CARNESANDWICH DE POLLO CLASICOFRAPPE DE MANGOFRAPPE DE FRESA', 4, 1),
(212, 198, '03', 1, 204, '2022-11-14 16:23:17', '', '', '', 'hgjj', '30.00', 30, 1, '0.00', '30.00', '', 'HUMITAGELATOMARACUYA FRESH', 3, 1),
(213, 199, '03', 1, 205, '2022-11-14 17:21:24', '', '', '', 'vcbjnnbvc', '53.00', 53, 1, '0.00', '53.00', '', 'EMPANADA DE CARNETEQUEÑOSFRAPPE DE MANGOESPRESATE', 4, 1),
(214, 200, '03', 1, 206, '2022-11-14 17:21:34', '', '', '', 'ENVIO', '18.00', 18, 1, '0.00', '18.00', '', 'FRAPPE DE FRUTOS SECOSVASO DOMO', 2, 1),
(215, 201, '03', 1, 207, '2022-11-14 18:12:31', '', '', '', 'DDD', '39.00', 39, 1, '0.00', '39.00', '', 'CAPUCCHINO SANDWICH DE PAVO', 4, 1),
(216, 202, '03', 1, 208, '2022-11-14 18:20:10', '', '', '', 'ss', '28.00', 28, 1, '0.00', '28.00', '', 'SANDWICH DE PAVOMARACUYA FRESH', 3, 1),
(217, 204, '03', 1, 209, '2022-11-14 18:30:53', '', '', '', 'ENVIO', '71.50', 71, 1, '0.00', '71.50', '', 'ORIANA COLORINFRAPPE DE MANGOFRAPPE DE FRESAVASO DOMO', 10, 1),
(218, 206, '03', 1, 210, '2022-11-14 18:41:01', '', '', '', 'bb', '45.50', 45, 1, '0.00', '45.50', '', 'HUMITAPANQUEQUE DE MANJARCAPUCCHINO ', 6, 1),
(219, 205, '03', 1, 211, '2022-11-14 18:58:59', '', '', '', 'ñññ', '190.50', 190, 1, '0.00', '190.50', '', 'CHICHARRON DE CHANCHOGALLINA  CON RECETA TRADICIONAL DE LA ABUELACAPUCCHINO PISCO SOURFRAPPE DE LUCU', 12, 1),
(220, 207, '03', 1, 212, '2022-11-14 19:05:01', '', '', '', 'ttt', '48.00', 48, 1, '0.00', '48.00', '', 'HUMITAMENTA', 12, 1),
(221, 209, '03', 1, 213, '2022-11-14 19:18:14', '', '', '', 'kkk', '62.00', 62, 1, '0.00', '62.00', '', 'CEJA DE SELVACHOCOPUCHINO AGUA SAN LUIS SIN GASFRAPPE DE MANGO', 5, 1),
(222, 208, '03', 1, 214, '2022-11-14 19:25:35', '', '', '', 'y64364w7w654', '37.00', 37, 1, '0.00', '37.00', '', 'CHOCLITO  FRITO CON QUESO LIVIANO FRITOCAPUCCHINO CHOCOPUCHINO ', 4, 1),
(223, 203, '03', 1, 215, '2022-11-14 19:56:54', '', '', '', 'e34', '148.00', 148, 1, '0.00', '148.00', '', 'EMPANADA DE CARNESANDWICH DE POLLO CLASICOAGUA SAN LUIS SIN GASCUSQUEÑA NEGRACORONAANDINOMARACUYA FR', 15, 1),
(224, 210, '03', 1, 216, '2022-11-14 20:12:03', '', '', '', 'uyyyy', '80.50', 80, 1, '0.00', '80.50', '', 'SANDWICH DE PAVOAMERICANO KIDSCAPUCCHINO SANDWICH DE PAVOENRROLLADO DE AVENA CON  POLLOCHOCOPUCHINO ', 8, 1),
(225, 219, '03', 1, 217, '2022-11-14 20:14:26', '', '', '', 'GG', '59.50', 59, 1, '0.00', '59.50', '', 'EMPANADA DE QUESOSANDWICH DE PAVOCHOCOPUCHINO NARANJILLA FRESH', 6, 1),
(226, 213, '03', 1, 218, '2022-11-14 20:16:12', '', '', '', 'vcchgg', '83.00', 83, 1, '0.00', '83.00', '', 'HUMITAEMPANADA DE QUESOAMERICANO GRANDECAPUCCHINO HUMITAGALLINA  CON RECETA TRADICIONAL DE LA ABUELA', 8, 1),
(227, 218, '03', 1, 219, '2022-11-14 20:17:00', '', '', '', 'llll', '40.00', 40, 1, '0.00', '40.00', '', 'FRAPPE DE MANGOFRAPPE DE FRESA', 3, 1),
(228, 211, '03', 1, 220, '2022-11-14 20:26:37', '', '', '', 'hhhhh', '32.50', 32, 1, '0.00', '32.50', '', 'HUMITAAMERICANO GRANDECHOCOPUCHINO HUMITA', 5, 1),
(229, 220, '03', 1, 221, '2022-11-14 20:31:12', '', '', '', 'ñññ', '50.50', 50, 1, '0.00', '50.50', '', 'EMPANADA DE QUESOSANDWICH LITECHOCOPUCHINO TINTO DE VERANO AGUA SAN LUIS SIN GAS', 5, 1),
(230, 214, '03', 1, 222, '2022-11-14 20:37:05', '', '', '', 'tt t', '49.00', 49, 1, '0.00', '49.00', '', 'EMPANADA DE HUAMBRILLAAMERICANO GRANDECAPUCCHINO ', 4, 1),
(231, 222, '03', 1, 223, '2022-11-14 20:48:27', '', '', '', 'EE', '48.50', 48, 1, '0.00', '48.50', '', 'SANDWICH DE POLLO CLASICOSANDWICH DE CHANCHITOCAPUCCHINO HIERBA LUISA', 6, 1),
(232, 221, '03', 1, 224, '2022-11-14 20:59:04', '', '', '', 'ñññ', '45.00', 45, 1, '0.00', '45.00', '', 'HUMITAEMPANADA DE QUESOEMPANADA DE CARNEAMERICANO GRANDECAPUCCHINO CAJA BIODEGRADABLE', 6, 1),
(233, 212, '03', 1, 225, '2022-11-14 21:06:31', '', '', '', '43434', '30.00', 30, 1, '0.00', '30.00', '', 'AMERICANO GRANDECAPUCCHINO FRESCA FELICIDAD', 3, 1),
(234, 224, '03', 1, 226, '2022-11-14 21:11:10', '', '', '', 'LLEVAR', '24.00', 24, 1, '0.00', '24.00', '', 'EMPANADA DE QUESOCAJA BIODEGRADABLE', 4, 1),
(235, 215, '03', 1, 227, '2022-11-14 21:14:40', '', '', '', 'kkk', '102.50', 102, 1, '0.00', '102.50', '', 'EMPANADA DE QUESOGALLINA  CON RECETA TRADICIONAL DE LA ABUELACAFE A LA OLLACHOCOPUCHINO EMPANADA DE ', 9, 1),
(236, 217, '03', 1, 228, '2022-11-14 21:20:29', '', '', '', 'kkkk', '63.50', 63, 1, '0.00', '63.50', '', 'CHICHARRON DE CHANCHOCAFE A LA OLLACAPUCCHINO MENTAMENTA', 6, 1),
(237, 216, '03', 1, 229, '2022-11-14 21:33:13', '', '', '', 'gff', '72.50', 72, 1, '0.00', '72.50', '', 'SANDWICH DE PAVOCAPUCCHINO CHOCLITO  FRITO CON QUESO NARANJILLA FRESHGALLINA  CON RECETA TRADICIONAL', 6, 1),
(238, 225, '03', 1, 230, '2022-11-14 21:38:43', '', '', '', 'W4QW6YTRED', '31.50', 31, 1, '0.00', '31.50', '', 'EMPANADA DE CARNECAPUCCHINO ', 3, 1),
(239, 26, '03', 1, 231, '2022-11-14 21:42:25', '', '', '', 'safas', '33.00', 33, 1, '0.00', '33.00', '', 'CEJA DE SELVAPIÑA Y HIERBA LUISA FRESH', 3, 1),
(240, 226, '03', 1, 232, '2022-11-14 21:49:59', '', '', '', 'kkk', '44.00', 44, 1, '0.00', '44.00', '', 'PANQUEQUE ESPECIALSANDWICH DE PAVOCAPUCCHINO CAPUCCHINO ', 4, 1),
(241, 230, '03', 1, 233, '2022-11-14 21:53:51', '', '', '', 'YTFCUJY7Y', '25.00', 25, 1, '0.00', '25.00', '', 'ORIANA VASO DOMO', 4, 1),
(242, 228, '03', 1, 234, '2022-11-14 21:59:00', '', '', '', 'kk', '40.00', 40, 1, '0.00', '40.00', '', 'PANQUEQUE ESPECIALEMPANADA DE QUESOAGUA SAN LUIS SIN GAS', 4, 1),
(243, 227, '03', 1, 235, '2022-11-14 22:12:40', '', '', '', 'kkkk', '31.00', 31, 1, '0.00', '31.00', '', 'FRAPPE DE LUCUMAFRAPPE DE FRUTOS SECOS', 2, 1),
(244, 183, '03', 1, 236, '2022-11-14 22:20:38', '', '', '', 'u', '54.00', 54, 1, '0.00', '54.00', '', 'PANQUEQUE ESPECIALSANDWICH DE POLLO CLASICOAMERICANO GRANDEEMPANADA DE CARNECAJA BIODEGRADABLE', 7, 1),
(245, 231, '03', 1, 237, '2022-11-14 22:25:20', '', '', '', 'lll', '52.50', 52, 1, '0.00', '52.50', '', 'PANQUEQUE DE MANJARTRIPLE AMERICANOCAFE A LA OLLAAMERICANO GRANDECHOCOPUCHINO EMPANADA DE CARNE', 6, 1),
(246, 232, '03', 1, 238, '2022-11-14 22:34:11', '', '', '', 'kkk', '37.50', 37, 1, '0.00', '37.50', '', 'EMPANADA DE QUESOSANDWICH QUESO SUIZOCAPUCCHINO KIDSCOCA COLA', 5, 1),
(247, 233, '03', 1, 239, '2022-11-14 22:43:34', '', '', '', 'llll', '55.50', 55, 1, '0.00', '55.50', '', 'EMPANADA DE CARNESANDWICH DE PAVOORIANA ', 5, 1),
(248, 229, '03', 1, 240, '2022-11-14 22:44:44', '', '', '', 'kkk', '47.50', 47, 1, '0.00', '47.50', '', 'SANDWICH DE POLLO CLASICOCHICHARRON DE CHANCHOCAFE A LA OLLAMENTACAPUCCHINO ', 5, 1),
(249, 236, '03', 1, 241, '2022-11-14 22:45:36', '', '', '', 'YTFDYIJ', '27.00', 27, 1, '0.00', '27.00', '', 'FRAPPE DE MANGOFRAPPE DE LUCUMA', 2, 1),
(250, 235, '03', 1, 242, '2022-11-14 22:48:05', '', '', '', 'll', '89.50', 89, 1, '0.00', '89.50', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELACAFE A LA OLLANARANJILLA FRESH', 6, 1),
(251, 223, '03', 1, 243, '2022-11-14 22:49:17', '', '', '', 'kkk', '108.50', 108, 1, '0.00', '108.50', '', 'SANDWICH POLLO CON DURAZNOSANDWICH DE PAVOCHICHARRON DE CHANCHOAMERICANO GRANDEFRAPPE DE FRESAMENTAA', 10, 1),
(252, 234, '03', 1, 244, '2022-11-14 23:03:04', '', '', '', 'DDDD', '53.00', 53, 1, '0.00', '53.00', '', 'EMPANADA DE QUESOEMPANADAS DE CHAMPIÑONESCAPUCCHINO AGUA SAN LUIS SIN GASNARANJILLA FRESHBABACO', 6, 1),
(253, 26, '03', 1, 245, '2022-11-14 23:17:48', '', '', '', 'safas', '64.00', 64, 1, '0.00', '64.00', '', 'EMPANADA DE HUAMBRILLASANDWICH DE POLLO CLASICOCAFE A LA OLLACHILCANO CLASICOCHILCANO DE MARACUYA', 6, 1),
(254, 238, '03', 1, 246, '2022-11-15 18:12:04', '', '', '', 'ñññ', '37.50', 37, 1, '0.00', '37.50', '', 'EMPANADA DE QUESOSANDWICH DE CHANCHITOAMERICANO GRANDECAPUCCHINO ', 4, 1),
(255, 237, '03', 1, 247, '2022-11-15 18:22:44', '', '', '', 'lll', '50.00', 50, 1, '0.00', '50.00', '', 'KEKE DE CHOCOLATEORIANA PANQUEQUE DE MANJAR', 6, 1),
(256, 239, '03', 1, 248, '2022-11-15 18:40:37', '', '', '', 'jjj', '134.50', 134, 1, '0.00', '134.50', '', 'EMPANADA DE QUESOEMPANADA DE CARNETRIPLE TURISTACAFE A LA OLLAESPRESSOCHOCOPUCHINO EMPANADA DE QUESO', 21, 1),
(257, 240, '03', 1, 249, '2022-11-15 18:45:14', '', '', '', 'nvg m', '34.00', 34, 1, '0.00', '34.00', '', 'SANDWICH DE PAVOCAFE A LA OLLA', 4, 1),
(258, 243, '03', 1, 250, '2022-11-15 19:51:32', '', '', '', 'hhh', '35.00', 35, 1, '0.00', '35.00', '', 'SANDWICH DE PAVOPIÑA Y HIERBA LUISA FRESH', 4, 1),
(259, 241, '03', 1, 251, '2022-11-15 19:58:34', '', '', '', 'kkk', '66.00', 66, 1, '0.00', '66.00', '', 'NARANJA Y MENTA FRESHEMPANADA DE HUAMBRILLACAJA BIODEGRADABLENARANJILLA FRESHTEQUEÑOS', 7, 1),
(260, 242, '03', 1, 252, '2022-11-15 20:29:03', '', '', '', 'kkk', '33.00', 33, 1, '0.00', '33.00', '', 'HUMITAORIANA ', 4, 1),
(261, 244, '03', 1, 253, '2022-11-15 20:41:45', '', '', '', 'dsaewgra', '68.00', 68, 1, '0.00', '68.00', '', 'CEJA DE SELVAGALLINA  CON RECETA TRADICIONAL DE LA ABUELACHOCOPUCHINO ', 4, 1),
(262, 246, '03', 1, 254, '2022-11-15 20:57:55', '', '', '', 'ff', '28.00', 28, 1, '0.00', '28.00', '', 'EMPANADA DE QUESOHIERBA LUISAMENTA', 4, 1),
(263, 248, '03', 1, 255, '2022-11-15 20:58:27', '', '', '', 'vxvbcbvc', '35.00', 35, 1, '0.00', '35.00', '', 'SANDWICH DE PAVOAMERICANO GRANDE', 4, 1),
(264, 247, '03', 1, 256, '2022-11-15 20:59:49', '', '', '', 'cxcvcxc', '37.50', 37, 1, '0.00', '37.50', '', 'CEJA DE SELVACAPUCCHINO CHOCOPUCHINO ', 3, 1),
(265, 245, '03', 1, 257, '2022-11-15 21:02:13', '', '', '', ' xczxzxx', '22.50', 22, 1, '0.00', '22.50', '', 'SANDWICH DE PAVOCAPUCCHINO MANZANILLA', 3, 1),
(266, 249, '03', 1, 258, '2022-11-15 21:07:54', '', '', '', 'hgfg', '45.00', 45, 1, '0.00', '45.00', '', 'EMPANADA DE QUESOEMPANADA DE CARNECAJA BIODEGRADABLECAPUCCHINO VASO POLIPAPEL CALIENTE', 8, 1),
(267, 253, '03', 1, 259, '2022-11-15 21:44:03', '', '', '', 'desedd', '40.00', 40, 1, '0.00', '40.00', '', 'QUESILLO CON MIELEMPANADA DE QUESOCHOCOPUCHINO ', 4, 1),
(268, 251, '03', 1, 260, '2022-11-15 21:54:54', '', '', '', 'bgf', '68.50', 68, 1, '0.00', '68.50', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELACAPUCCHINO SANDWICH DE PAVO', 5, 1),
(269, 252, '03', 1, 261, '2022-11-15 21:59:19', '', '', '', 'ttthff', '99.00', 99, 1, '0.00', '99.00', '', 'EMPANADA DE QUESOCHOCLITO  FRITO CON QUESO ORIANA FRAPPE DE FRESAEMPANADA DE QUESOCAPUCCHINO ', 9, 1),
(270, 250, '03', 1, 262, '2022-11-15 22:00:42', '', '', '', 'hhhhh', '41.00', 41, 1, '0.00', '41.00', '', 'SANDWICH DE POLLO CLASICOBOMBOMCHOCOPUCHINO BOMBOM', 5, 1),
(271, 254, '03', 1, 263, '2022-11-15 22:09:42', '', '', '', 'xds', '21.00', 21, 1, '0.00', '21.00', '', 'QUESILLO CON MIELESPRESATE', 2, 1),
(272, 183, '03', 1, 264, '2022-11-15 22:15:25', '', '', '', 'u', '47.00', 47, 1, '0.00', '47.00', '', 'EMPANADA DE HUAMBRILLASANDWICH DE PAVOCAPUCCHINO ORIANA ', 4, 1),
(273, 255, '03', 1, 265, '2022-11-15 22:43:08', '', '', '', 'rre', '29.00', 29, 1, '0.00', '29.00', '', 'TAMALCAPUCCHINO ', 4, 1),
(274, 256, '03', 1, 266, '2022-11-15 22:58:21', '', '', '', 'gfytrr', '120.00', 120, 1, '0.00', '120.00', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELACAFE A LA OLLAGALLINA  CON RECETA TRADICIONAL DE LA ABUE', 6, 1),
(275, 258, '03', 1, 267, '2022-11-16 18:10:56', '', '', '', 'fr54er', '29.00', 29, 1, '0.00', '29.00', '', 'HUMITACAPUCCHINO ', 4, 1),
(276, 257, '03', 1, 268, '2022-11-16 18:35:55', '', '', '', 'saFa', '61.50', 61, 1, '0.00', '61.50', '', 'TAMALPANQUEQUE DE MANJAREMPANADA DE CARNECAPUCCHINO ', 7, 1),
(277, 259, '03', 1, 269, '2022-11-16 18:37:58', '', '', '', 'dgfjh', '24.00', 24, 1, '0.00', '24.00', '', 'EMPANADA DE QUESOCAJA BIODEGRADABLE', 4, 1),
(278, 260, '03', 1, 270, '2022-11-16 18:38:06', '', '', '', 'ELIAN', '13.50', 13, 1, '0.00', '13.50', '', 'PANQUEQUE DE MANJARSANDWICH DE POLLO CLASICO', 2, 1),
(279, 263, '03', 1, 271, '2022-11-16 18:48:18', '', '', '', 'ytytytyt', '43.00', 43, 1, '0.00', '43.00', '', 'EMPANADA DE CARNELATTECHOCOLATEORIANA ', 4, 1),
(280, 264, '03', 1, 272, '2022-11-16 19:32:48', '', '', '', 'hyjfxgg b ', '38.00', 38, 1, '0.00', '38.00', '', 'HUMITATAMALQUESILLO CON MIELCAPUCCHINO ', 5, 1),
(281, 261, '03', 1, 273, '2022-11-16 19:56:51', '', '', '', 'olioiuyo', '51.00', 51, 1, '0.00', '51.00', '', 'PANQUEQUE DE MANJARPANQUEQUE ESPECIALNARANJILLA FRESHTAMALUVA FRESH', 6, 1),
(282, 267, '03', 1, 274, '2022-11-16 20:03:21', '', '', '', 'ñ{ñññ', '104.00', 104, 1, '0.00', '104.00', '', 'PANQUEQUE DE MANJARCEJA DE SELVACAPUCCHINO CAPUCCHINO ', 9, 1),
(283, 268, '03', 1, 275, '2022-11-16 20:14:57', '', '', '', 'ENVIO', '178.50', 178, 1, '0.00', '178.50', '', 'EMPANADA DE QUESOSANDWICH DE PAVOCAJA BIODEGRADABLEAMERICANO GRANDEVASO POLIPAPEL CALIENTE', 29, 1),
(284, 269, '03', 1, 276, '2022-11-16 20:15:06', '', '', '', 'jhbkjhbkjh', '26.50', 26, 1, '0.00', '26.50', '', 'HANSEL Y GRETELORIANA VASO DOMO', 4, 1),
(285, 270, '03', 1, 277, '2022-11-16 20:39:15', '', '', '', 'htrr', '71.00', 71, 1, '0.00', '71.00', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELAHIERBA LUISAHUMITA', 5, 1),
(286, 266, '03', 1, 278, '2022-11-16 20:42:09', '', '', '', 'hgdhcnbv', '74.00', 74, 1, '0.00', '74.00', '', 'CALDO DE PAICOCEJA DE SELVAGALLINA  CON RECETA TRADICIONAL DE LA ABUELANARANJILLA FRESH', 5, 1),
(287, 26, '03', 1, 279, '2022-11-16 20:49:45', '', '', '', 'safas', '75.00', 75, 1, '0.00', '75.00', '', 'LONCHE SERRANOGALLINA  CON RECETA TRADICIONAL DE LA ABUELAAMERICANO GRANDEMANZANILLAAMERICANO GRANDE', 7, 1),
(288, 275, '03', 1, 280, '2022-11-16 21:24:21', '', '', '', 'GERFD', '11.00', 11, 1, '0.00', '11.00', '', 'CHOCOPUCHINO VASO POLIPAPEL CALIENTE', 2, 1),
(289, 271, '03', 1, 281, '2022-11-16 21:31:24', '', '', '', 'kk', '267.50', 267, 1, '0.00', '267.50', '', 'TAMALEMPANADA DE CARNESANDWICH POLLO CON DURAZNOCEJA DE SELVACHICHARRON DE CHANCHOLONCHE SERRANOCAFE', 22, 1),
(290, 272, '03', 1, 282, '2022-11-16 21:34:42', '', '', '', 'yttiiuy', '35.00', 35, 1, '0.00', '35.00', '', 'TRIPLE AMERICANOESPRESATE', 3, 1),
(291, 278, '03', 1, 283, '2022-11-16 21:55:46', '', '', '', 'FXXC', '12.00', 12, 1, '0.00', '12.00', '', 'EMPANADA DE CARNECAJA BIODEGRADABLE', 2, 1),
(292, 262, '03', 1, 284, '2022-11-16 22:00:40', '', '', '', 'sgfdgdf', '112.00', 112, 1, '0.00', '112.00', '', 'CEJA DE SELVAAMERICANO GRANDECEJA DE SELVAHUMITAAMERICANO GRANDEEMPANADA DE QUESOCAPUCCHINO ', 11, 1),
(293, 274, '03', 1, 285, '2022-11-16 22:07:17', '', '', '', 'hgfhg', '23.50', 23, 1, '0.00', '23.50', '', 'ESPRESATEORIANA ', 2, 1),
(294, 265, '03', 1, 286, '2022-11-16 22:07:27', '', '', '', 'jpoujhy', '189.50', 189, 1, '0.00', '189.50', '', 'SANDWICH POLLO CON DURAZNOGALLINA  CON RECETA TRADICIONAL DE LA ABUELACORTADOMOJITONARANJILLA FRESHS', 13, 1),
(295, 273, '03', 1, 287, '2022-11-16 22:10:21', '', '', '', 'kkk', '45.00', 45, 1, '0.00', '45.00', '', 'SANDWICH DE PAVOCAFE A LA OLLAPIÑA Y HIERBA LUISA FRESHMENTAPIÑA Y HIERBA LUISA FRESH', 6, 1),
(296, 276, '03', 1, 288, '2022-11-16 22:13:00', '', '', '', 'kkk', '34.00', 34, 1, '0.00', '34.00', '', 'CAPUCCHINO ORIANA FRAPPE DE NARANJILLA', 3, 1),
(297, 279, '03', 1, 289, '2022-11-16 22:36:31', '', '', '', '7u586', '19.00', 19, 1, '0.00', '19.00', '', 'CAPUCCHINO ', 2, 1),
(298, 277, '03', 1, 290, '2022-11-16 22:43:00', '', '', '', 'kkk', '64.00', 64, 1, '0.00', '64.00', '', 'EMPANADA DE QUESOEMPANADAS DE CHAMPIÑONESACEITUNAS VERDESCHOCOPUCHINO ', 6, 1),
(299, 280, '03', 1, 291, '2022-11-16 22:45:03', '', '', '', 'hfchgfdhghgdhgfd', '26.50', 26, 1, '0.00', '26.50', '', 'CAPUCCHINO SANDWICH DE POLLO CLASICO', 3, 1);
INSERT INTO `facturacion` (`id`, `id_pedido`, `id_tipo_comprobante`, `numero`, `correlativo`, `fecha_registro`, `documento`, `razon_social`, `direccion`, `usuario`, `monto`, `puntos`, `estado_puntos`, `monto_descuento`, `monto_amortizacion`, `ticket`, `producto`, `cantidad_producto`, `Id_medio_pago`) VALUES
(300, 282, '03', 1, 292, '2022-11-17 18:11:58', '', '', '', 'wefs', '76.50', 76, 1, '0.00', '76.50', '', 'PANQUEQUE DE MANJARORIANA FRAPPE DE LUCUMAFRAPPE DE FRESAHUMITA', 8, 1),
(301, 281, '03', 1, 293, '2022-11-17 18:34:24', '', '', '', 'kkk', '60.00', 60, 1, '0.00', '60.00', '', 'EMPANADA DE QUESOCAPUCCHINO CAPUCCHINO ', 6, 1),
(302, 286, '03', 1, 294, '2022-11-17 19:19:47', '', '', '', '4wre', '87.00', 87, 1, '0.00', '87.00', '', 'SANDWICH DE PAVOCHICHARRON DE CHANCHOCAPUCCHINO PIÑA Y HIERBA LUISA FRESH', 7, 1),
(303, 283, '03', 1, 295, '2022-11-17 19:23:07', '', '', '', 'jjj', '26.00', 26, 1, '0.00', '26.00', '', 'HANSEL Y GRETEL', 2, 1),
(304, 284, '03', 1, 296, '2022-11-17 19:28:49', '', '', '', 'hujgviujhg', '74.00', 74, 1, '0.00', '74.00', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELACAFE A LA OLLAGALLINA  CON RECETA TRADICIONAL DE LA ABUE', 4, 1),
(305, 289, '03', 1, 297, '2022-11-17 19:44:10', '', '', '', 'hhghgfhgf', '48.00', 48, 1, '0.00', '48.00', '', 'SANDWICH DE POLLO CLASICOCHOCOLATE', 6, 1),
(306, 287, '03', 1, 298, '2022-11-17 19:55:21', '', '', '', 'faedsz', '21.50', 21, 1, '0.00', '21.50', '', 'CHOCOLATEHANSEL Y GRETEL', 2, 1),
(307, 285, '03', 1, 299, '2022-11-17 19:55:44', '', '', '', 'iiii', '50.00', 50, 1, '0.00', '50.00', '', 'EMPANADA DE QUESOCAFE A LA OLLACAFE A LA OLLA', 6, 1),
(308, 294, '03', 1, 300, '2022-11-17 20:01:13', '', '', '', 'ikk', '14.00', 14, 1, '0.00', '14.00', '', 'CAFE A LA OLLA', 2, 1),
(309, 183, '03', 1, 301, '2022-11-17 20:14:54', '', '', '', 'u', '49.50', 49, 1, '0.00', '49.50', '', 'EMPANADA DE QUESOTEQUEÑOSAMERICANO GRANDEFRAPPE DE FRESA', 4, 1),
(310, 288, '03', 1, 302, '2022-11-17 20:15:08', '', '', '', 'utfhgf', '76.50', 76, 1, '0.00', '76.50', '', 'EMPANADA DE QUESOEMPANADA DE HUAMBRILLAORIANA CHOCLITO SANCOCHADO CON QUESOCALDO DE PAICONARANJILLA ', 7, 1),
(311, 296, '03', 1, 303, '2022-11-17 20:16:18', '', '', '', 'grgfgf', '19.50', 19, 1, '0.00', '19.50', '', 'SANDWICH DE PAVOCAPUCCHINO ', 2, 1),
(312, 293, '03', 1, 304, '2022-11-17 20:20:37', '', '', '', 'kkk', '32.50', 32, 1, '0.00', '32.50', '', 'PANQUEQUE DE MANJAREMPANADA DE HUAMBRILLANARANJILLA FRESHHIERBA LUISA', 4, 1),
(313, 26, '03', 1, 305, '2022-11-17 20:21:24', '', '', '', 'safas', '28.00', 28, 1, '0.00', '28.00', '', 'EMPANADA DE CARNEAMERICANO GRANDECAPUCCHINO ', 3, 1),
(314, 295, '03', 1, 306, '2022-11-17 20:33:45', '', '', '', 'ytfrytfr', '19.50', 19, 1, '0.00', '19.50', '', 'SANDWICH DE CHANCHITOCAFE A LA OLLAMANZANILLA', 3, 1),
(315, 298, '03', 1, 307, '2022-11-17 21:02:14', '', '', '', 'tyuj', '78.00', 78, 1, '0.00', '78.00', '', 'SANDWICH DE PAVOESPRESATEFRAPPE DE MANGOSANDWICH DE PAVO', 7, 1),
(316, 291, '03', 1, 308, '2022-11-17 21:10:28', '', '', '', 'jjj', '102.50', 102, 1, '0.00', '102.50', '', 'EMPANADA DE QUESOSANDWICH DE PAVOGALLINA  CON RECETA TRADICIONAL DE LA ABUELACAPUCCHINO LATTEMENTAME', 9, 1),
(317, 290, '03', 1, 309, '2022-11-17 21:11:09', '', '', '', 'jjjj', '37.00', 37, 1, '0.00', '37.00', '', 'EMPANADA DE QUESOCHILCANO DE MARACUYA', 3, 1),
(318, 300, '03', 1, 310, '2022-11-17 21:14:00', '', '', '', 'kkk', '63.00', 63, 1, '0.00', '63.00', '', 'EMPANADA DE QUESOCHOCOPUCHINO ', 6, 1),
(319, 292, '03', 1, 311, '2022-11-17 21:30:52', '', '', '', 'ngccv', '65.50', 65, 1, '0.00', '65.50', '', 'SANDWICH POLLO CON DURAZNOSANDWICH DE PAVOCAPUCCHINO FRESCA FELICIDADEMPANADA DE QUESOEMPANADAS DE C', 6, 1),
(320, 297, '03', 1, 312, '2022-11-17 21:41:59', '', '', '', 'kkk', '42.50', 42, 1, '0.00', '42.50', '', 'AMERICANO GRANDENARANJILLA FRESHQUESILLO CON MIELEMPANADA DE QUESO', 5, 1),
(321, 301, '03', 1, 313, '2022-11-17 21:49:36', '', '', '', 'kkk', '49.00', 49, 1, '0.00', '49.00', '', 'HUMITASANDWICH DE POLLO CLASICOAMERICANO GRANDECHOCOPUCHINO ORIANA ', 6, 1),
(322, 299, '03', 1, 314, '2022-11-17 21:50:53', '', '', '', 'kkk', '160.00', 160, 1, '0.00', '160.00', '', 'EMPANADA DE CARNESANDWICH DE PAVOCAPUCCHINO CUZQUEÑA TRIGO CUZQUEÑA TRIGO CAPUCCHINO PILSEN ', 19, 1),
(323, 302, '03', 1, 315, '2022-11-17 22:15:31', '', '', '', 'gzrsgfdr', '147.50', 147, 1, '0.00', '147.50', '', 'HUMITAPANQUEQUE ESPECIALGALLINA  CON RECETA TRADICIONAL DE LA ABUELACAPUCCHINO CHOCOPUCHINO NARANJIL', 13, 1),
(324, 303, '03', 1, 316, '2022-11-17 22:21:05', '', '', '', 'hfdhgfdx', '46.00', 46, 1, '0.00', '46.00', '', 'EMPANADA DE HUAMBRILLATRIPLE TURISTANARANJA Y MENTA FRESH', 4, 1),
(325, 304, '03', 1, 317, '2022-11-18 16:26:17', '', '', '', 'ggfrfds', '175.00', 175, 1, '0.00', '175.00', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELATEQUEÑOSCAPUCCHINO HANSEL Y GRETELCAPUCCHINO HUMITAESPRE', 11, 1),
(326, 306, '03', 1, 318, '2022-11-18 16:26:26', '', '', '', 'jj', '64.50', 64, 1, '0.00', '64.50', '', 'QUESILLO CON MIELEMPANADA DE CARNECHICHARRON DE CHANCHOCAFE A LA OLLAFRAPPE DE FRUTOS SECOS', 5, 1),
(327, 305, '03', 1, 319, '2022-11-18 16:26:36', '', '', '', 'lll', '56.00', 56, 1, '0.00', '56.00', '', 'SANDWICH DE POLLO CLASICOSANDWICH DE PAVOCHOCOPUCHINO EMPANADA DE QUESO', 6, 1),
(328, 307, '03', 1, 320, '2022-11-18 17:03:05', '', '', '', 'DASAS', '14.00', 14, 1, '0.00', '14.00', '', 'FRAPPE DE NARANJILLAVASO DOMO', 2, 1),
(329, 308, '03', 1, 321, '2022-11-18 18:11:54', '', '', '', 'm', '36.00', 36, 1, '0.00', '36.00', '', 'QUESILLO CON MIELSANDWICH DE CHANCHITOCAFE A LA OLLACAJA BIODEGRADABLE', 5, 1),
(330, 309, '03', 1, 322, '2022-11-18 18:22:59', '', '', '', 'lll', '31.00', 31, 1, '0.00', '31.00', '', 'EMPANADA DE QUESOCHOCOPUCHINO ', 3, 1),
(331, 310, '03', 1, 323, '2022-11-18 18:29:19', '', '', '', 'llll', '77.50', 77, 1, '0.00', '77.50', '', 'PANQUEQUE ESPECIALORIANA AGUA SAN LUIS SIN GASAGUA SAN LUIS SIN GAS', 7, 1),
(332, 313, '03', 1, 324, '2022-11-18 18:47:48', '', '', '', '6525432432', '53.50', 53, 1, '0.00', '53.50', '', 'EMPANADA DE HUAMBRILLASANDWICH POLLO CON DURAZNOCAPUCCHINO ', 5, 1),
(333, 312, '03', 1, 325, '2022-11-18 18:58:10', '', '', '', 'kkk', '28.00', 28, 1, '0.00', '28.00', '', 'MARACUYAFRAPPE DE FRESA', 2, 1),
(334, 314, '03', 1, 326, '2022-11-18 18:58:23', '', '', '', 'DFGF', '41.50', 41, 1, '0.00', '41.50', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELATAPER BIODEGRADABLEMARACUYA FRESHVASO DOMO', 4, 1),
(335, 311, '03', 1, 327, '2022-11-18 19:00:03', '', '', '', 'kkk', '42.00', 42, 1, '0.00', '42.00', '', 'EMPANADA DE CARNEMOJITOANDINO', 3, 1),
(336, 315, '03', 1, 328, '2022-11-18 19:10:46', '', '', '', 'ewwwwewr', '57.50', 57, 1, '0.00', '57.50', '', 'EMPANADA DE QUESOEMPANADA DE HUAMBRILLACAPUCCHINO CHOCOPUCHINO ', 5, 1),
(337, 316, '03', 1, 329, '2022-11-18 19:37:18', '', '', '', 'kkk', '77.00', 77, 1, '0.00', '77.00', '', 'EMPANADA DE QUESOCAPUCCHINO KIDSCAPUCCHINO CHOCOPUCHINO KIDS', 8, 1),
(338, 317, '03', 1, 330, '2022-11-18 19:52:59', '', '', '', 'lll', '39.50', 39, 1, '0.00', '39.50', '', 'TEQUEÑOSPISCO SOURNARANJILLA FRESH', 3, 1),
(339, 319, '03', 1, 331, '2022-11-18 20:01:11', '', '', '', 'DEWSGFDHGDF', '24.00', 24, 1, '0.00', '24.00', '', 'EMPANADA DE QUESOCAJA BIODEGRADABLE', 4, 1),
(340, 324, '03', 1, 332, '2022-11-18 20:37:08', '', '', '', 'URER', '41.00', 41, 1, '0.00', '41.00', '', 'EMPANADA DE QUESOCAPUCCHINO ', 4, 1),
(341, 321, '03', 1, 333, '2022-11-18 20:39:07', '', '', '', 'fgfffdwgtERYGHHG', '66.50', 66, 1, '0.00', '66.50', '', 'SANDWICH DE POLLO CLASICOCAPUCCHINO CHOCOPUCHINO KEKE DE CAFETRIPLE TURISTASANDWICH DE POLLO CLASICO', 7, 1),
(342, 318, '03', 1, 334, '2022-11-18 20:42:33', '', '', '', 'kkk', '53.00', 53, 1, '0.00', '53.00', '', 'EMPANADA DE QUESOEMPANADA DE CARNESANDWICH DE POLLO CLASICOAMERICANO GRANDECHOCOLATE', 6, 1),
(343, 326, '03', 1, 335, '2022-11-18 20:44:32', '', '', '', 'WRW', '34.50', 34, 1, '0.00', '34.50', '', 'SANDWICH QUESO BLANCOSANDWICH QUESO SUIZOCAPUCCHINO FRAPPE DE MANGO', 4, 1),
(344, 320, '03', 1, 336, '2022-11-18 20:48:54', '', '', '', 'jjj', '106.50', 106, 1, '0.00', '106.50', '', 'EMPANADA DE QUESOEMPANADAS DE CHAMPIÑONESSANDWICH DE CHANCHITOCALDO DE PAICOTAPER BIODEGRADABLEAGUA ', 11, 1),
(345, 327, '03', 1, 337, '2022-11-18 20:53:45', '', '', '', 'Q', '51.00', 51, 1, '0.00', '51.00', '', 'CHOCLITO  FRITO CON QUESO CHOCLITO SANCOCHADO CON QUESOAMERICANO GRANDEJARRA DE NARANJILLA  FRESH', 5, 1),
(346, 323, '03', 1, 338, '2022-11-18 20:55:29', '', '', '', 'WETTQ', '44.00', 44, 1, '0.00', '44.00', '', 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELAMANZANILLACHOCLITO  FRITO CON QUESO ', 4, 1),
(347, 322, '03', 1, 339, '2022-11-18 21:03:49', '', '', '', 'hhhh', '66.50', 66, 1, '0.00', '66.50', '', 'SANDWICH DE PAVOCEJA DE SELVACAPUCCHINO ', 6, 1),
(348, 328, '03', 1, 340, '2022-11-18 21:17:54', '', '', '', 'kkk', '39.00', 39, 1, '0.00', '39.00', '', 'HUMITACAPUCCHINO HUMITA', 6, 1),
(349, 329, '03', 1, 341, '2022-11-18 21:27:22', '', '', '', 'hfdrujhtruter', '39.00', 39, 1, '0.00', '39.00', '', 'EMPANADA DE QUESOCAPUCCHINO PIÑA Y HIERBA LUISA FRESH', 4, 1),
(350, 325, '03', 1, 342, '2022-11-18 21:48:51', '', '', '', 'lll', '115.50', 115, 1, '0.00', '115.50', '', 'SANDWICH DE POLLO CLASICOSANDWICH DE PAVOCAPUCCHINO HIERBA LUISASANDWICH DE POLLO CLASICO', 13, 1),
(351, 334, '03', 1, 343, '2022-11-18 21:51:06', '', '', '', 'ouiuyg', '12.50', 12, 1, '0.00', '12.50', '', 'ORIANA VASO DOMO', 2, 1),
(352, 331, '03', 1, 344, '2022-11-18 21:53:41', '', '', '', 'kkk', '58.00', 58, 1, '0.00', '58.00', '', 'EMPANADA DE CARNESANDWICH DE PAVOCAFE A LA OLLAHIERBA LUISA', 7, 1),
(353, 332, '03', 1, 345, '2022-11-18 22:03:01', '', '', '', 'lll', '25.00', 25, 1, '0.00', '25.00', '', 'HUMITACHOCOPUCHINO ', 3, 1),
(354, 335, '03', 1, 346, '2022-11-18 22:05:43', '', '', '', 'rrw', '80.00', 80, 1, '0.00', '80.00', '', 'HUMITATAMALPANQUEQUE DE MANJARSANDWICH DE POLLO CLASICOCHOCOLATE  KIDSCHOCOPUCHINO KIDSCAPUCCHINO KI', 12, 1),
(355, 330, '03', 1, 347, '2022-11-18 22:09:37', '', '', '', 'ujdjtr', '15.50', 15, 1, '0.00', '15.50', '', 'LIVIANO SANCOCHADOMENTA', 3, 1),
(356, 333, '03', 1, 348, '2022-11-18 22:09:51', '', '', '', 'hjhgfjhg', '120.00', 120, 1, '0.00', '120.00', '', 'HUMITASANDWICH DE PAVONARANJILLA FRESHPIÑA Y HIERBA LUISA FRESHHUMITANARANJILLA FRESH', 16, 1),
(357, 183, '03', 1, 349, '2022-11-18 22:21:28', '', '', '', 'u', '133.50', 133, 1, '0.00', '133.50', '', 'NARANJILLA FRESHCOLORINNARANJILLA FRESHGALLINA  CON RECETA TRADICIONAL DE LA ABUELANARANJILLA FRESHH', 9, 1),
(358, 337, '03', 1, 350, '2022-11-18 22:23:36', '', '', '', 'ytrytruytr', '66.00', 66, 1, '0.00', '66.00', '', 'EMPANADA DE QUESOEMPANADA DE HUAMBRILLAINFUSION DE EUCALIPTO MAS LIMON Y MIEL', 7, 1),
(359, 340, '03', 1, 351, '2022-11-18 22:35:23', '', '', '', 'jhgjh', '25.00', 25, 1, '0.00', '25.00', '', 'ORIANA VASO DOMO', 4, 1),
(360, 338, '03', 1, 352, '2022-11-18 22:37:29', '', '', '', 'teererery', '41.50', 41, 1, '0.00', '41.50', '', 'SANDWICH DE POLLO CLASICOAMERICANO GRANDECAPUCCHINO ESPRESATEHUMITA', 5, 1),
(361, 336, '03', 1, 353, '2022-11-18 22:40:09', '', '', '', 'kk', '42.00', 42, 1, '0.00', '42.00', '', 'HUMITACAPUCCHINO SANDWICH DE PAVOAMERICANO GRANDESANDWICH DE PAVO', 5, 1),
(362, 339, '03', 1, 354, '2022-11-18 22:44:48', '', '', '', 'jjj', '41.00', 41, 1, '0.00', '41.00', '', 'CAPUCCHINO ORIANA FRAPPE DE MANGOKEKE DE CAFE', 4, 1),
(363, 342, '01', 1, 3, '2022-11-25 10:11:11', '', '', '', 'JORGE', '5.00', 5, 1, '0.00', '5.00', '', 'INFUSION DE PEREJIL MAS LIMON', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log`
--

CREATE TABLE `log` (
  `id` int NOT NULL,
  `id_mesa` int NOT NULL,
  `id_pedido` int NOT NULL,
  `id_facturacion` int NOT NULL,
  `id_tipo_comprobante` char(2) NOT NULL,
  `numero` int NOT NULL,
  `correlativo` int NOT NULL,
  `new_correlativo` int NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medios_pago`
--

CREATE TABLE `medios_pago` (
  `id` int NOT NULL,
  `descripcion` varchar(50) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `estado` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `medios_pago`
--

INSERT INTO `medios_pago` (`id`, `descripcion`, `estado`) VALUES
(1, 'EFECTIVO', 1),
(2, 'TARJETA', 1),
(3, 'YAPE', 1),
(4, 'PLIN', 1),
(5, 'LUQUITA', 1),
(6, 'PERSONAL', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mesa`
--

CREATE TABLE `mesa` (
  `id` int NOT NULL,
  `numero` varchar(100) NOT NULL,
  `ubicacion` varchar(15) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL DEFAULT '1',
  `estado` int NOT NULL DEFAULT '1',
  `estado_convencional` int NOT NULL DEFAULT '1',
  `disponibilidad` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `mesa`
--

INSERT INTO `mesa` (`id`, `numero`, `ubicacion`, `estado`, `estado_convencional`, `disponibilidad`) VALUES
(1, 'Barra 1', '2', 1, 2, 0),
(2, 'Barra 2', '2', 1, 1, 0),
(3, 'Barra 3', '2', 1, 1, 0),
(4, 'Barra 4', '2', 1, 1, 0),
(5, 'Mesa 1', '2', 1, 1, 0),
(6, 'Mesa 2', '2', 1, 1, 0),
(7, 'Mesa 3', '2', 1, 1, 0),
(8, 'Mesa 4', '2', 1, 1, 0),
(9, 'Mesa 5', '2', 1, 1, 0),
(10, 'Mesa 6', '2', 1, 1, 0),
(11, 'Banco 1', '2', 1, 1, 0),
(12, 'Banco 2', '2', 1, 1, 0),
(13, 'T01', '3', 1, 1, 0),
(14, 'T02', '3', 1, 1, 0),
(15, 'T03', '3', 1, 1, 0),
(16, 'T04', '3', 1, 1, 0),
(17, 'T05', '3', 1, 1, 0),
(18, 'T06', '3', 1, 1, 0),
(19, 'T07', '3', 1, 1, 0),
(20, 'T08', '3', 1, 1, 0),
(21, 'T09', '3', 1, 1, 0),
(22, 'T10', '3', 1, 1, 0),
(23, 'T11', '3', 1, 1, 0),
(24, 'T12', '3', 1, 1, 0),
(25, 'T13', '3', 1, 1, 0),
(26, 'T14', '3', 1, 1, 0),
(27, 'D1', '4', 1, 1, 0),
(28, 'D2', '4', 1, 1, 0),
(29, 'D3', '4', 1, 1, 0),
(30, 'D4', '4', 1, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `id` int NOT NULL,
  `id_mesa` int NOT NULL,
  `id_empleado` int NOT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` int NOT NULL DEFAULT '1',
  `nombre_cliente` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`id`, `id_mesa`, `id_empleado`, `fecha_registro`, `estado`, `nombre_cliente`) VALUES
(11, 1, 2, '2022-11-07 15:58:44', 2, 'ELIAN'),
(12, 2, 2, '2022-11-07 16:02:53', 2, 'GORDITA'),
(13, 3, 2, '2022-11-07 16:05:32', 2, 'KEIKO'),
(14, 4, 2, '2022-11-07 16:07:28', 2, 'ERROR'),
(15, 5, 2, '2022-11-07 16:08:21', 2, 'OHHH'),
(16, 6, 2, '2022-11-07 16:10:38', 2, 'NARANJA CAMBIO PRECIO'),
(17, 7, 2, '2022-11-07 16:12:10', 2, 'SD'),
(18, 8, 2, '2022-11-07 16:12:57', 2, 'FD'),
(19, 9, 2, '2022-11-07 16:14:08', 2, 'ERH'),
(20, 10, 2, '2022-11-07 16:15:41', 2, 'BV'),
(21, 11, 2, '2022-11-07 16:27:32', 2, 'GALLINERA'),
(22, 1, 2, '2022-11-07 16:29:31', 2, 'UYT'),
(23, 13, 9, '2022-11-07 17:03:32', 2, 'facturañ- 20487859487'),
(24, 22, 9, '2022-11-07 17:05:58', 2, 'pareja'),
(25, 14, 9, '2022-11-07 17:09:44', 2, 'b'),
(26, 21, 9, '2022-11-07 17:10:40', 3, 'safas'),
(27, 21, 9, '2022-11-07 17:10:41', 3, 'safas'),
(28, 9, 9, '2022-11-07 17:13:41', 2, 'h'),
(29, 15, 9, '2022-11-07 17:14:42', 2, 'zd'),
(30, 6, 7, '2022-11-07 17:17:26', 2, 'Z'),
(31, 5, 7, '2022-11-07 17:18:41', 2, 'M'),
(32, 17, 9, '2022-11-07 17:36:38', 2, 'chicas'),
(33, 16, 9, '2022-11-07 17:40:25', 2, 'señoras'),
(34, 1, 7, '2022-11-07 17:41:24', 2, 'PARA LLEVAR'),
(35, 18, 9, '2022-11-07 17:47:24', 2, 'parejera'),
(36, 10, 7, '2022-11-07 17:58:13', 2, 'PAO'),
(37, 5, 7, '2022-11-07 18:00:39', 2, 'PAO'),
(38, 20, 9, '2022-11-07 18:03:36', 2, 'pareja'),
(39, 13, 9, '2022-11-07 18:08:52', 2, 'señoritas'),
(40, 9, 7, '2022-11-07 18:27:48', 2, 'PAOLA}'),
(41, 23, 9, '2022-11-07 18:35:39', 2, 'señoritas'),
(42, 15, 9, '2022-11-07 18:40:32', 2, 'pareja'),
(43, 11, 7, '2022-11-07 18:46:22', 2, 'PAOLA}'),
(44, 19, 9, '2022-11-07 18:54:48', 2, 'jovenes'),
(45, 7, 7, '2022-11-07 18:57:48', 2, 'PÁO'),
(46, 1, 7, '2022-11-07 19:22:03', 2, 'envio'),
(47, 11, 7, '2022-11-07 19:34:15', 2, 'JOKOI'),
(48, 5, 7, '2022-11-07 20:00:15', 2, 'HBJG'),
(49, 20, 9, '2022-11-07 20:14:37', 2, 'señores'),
(50, 8, 7, '2022-11-07 20:19:05', 2, 'BN'),
(51, 14, 9, '2022-11-07 20:20:28', 2, 'pareja'),
(52, 9, 7, '2022-11-07 20:28:28', 2, 'BNJ'),
(53, 15, 9, '2022-11-07 20:42:25', 2, 'pareja'),
(54, 10, 7, '2022-11-07 21:12:32', 2, 'NHG'),
(55, 7, 7, '2022-11-07 21:16:44', 2, ' BBV'),
(56, 12, 7, '2022-11-07 21:18:26', 2, 'GGFFRFR'),
(57, 20, 9, '2022-11-07 21:28:24', 2, 'señores'),
(58, 6, 7, '2022-11-07 21:28:32', 2, 'HGVK'),
(59, 23, 9, '2022-11-07 21:30:04', 2, 'pareja'),
(60, 19, 9, '2022-11-07 21:32:15', 2, 'pareja'),
(61, 8, 2, '2022-11-08 17:51:07', 2, 'uytiuy'),
(62, 5, 2, '2022-11-08 17:54:11', 2, 'jjjh'),
(63, 18, 9, '2022-11-08 18:18:53', 2, 'pareja'),
(64, 10, 2, '2022-11-08 18:24:49', 2, 'vghgjh'),
(65, 17, 9, '2022-11-08 18:33:43', 2, 'señores'),
(66, 17, 9, '2022-11-08 18:33:43', 2, 'señores'),
(67, 5, 2, '2022-11-08 18:36:09', 2, 'ghygfy'),
(68, 24, 9, '2022-11-08 18:39:52', 2, 'pareja'),
(69, 14, 9, '2022-11-08 18:43:24', 2, 'señores'),
(70, 22, 7, '2022-11-08 19:10:02', 2, 'pareja'),
(71, 10, 2, '2022-11-08 19:20:14', 2, 'bghhg'),
(72, 1, 7, '2022-11-08 19:21:41', 2, 'envio'),
(73, 13, 2, '2022-11-08 19:23:32', 2, 'señores'),
(74, 9, 2, '2022-11-08 19:24:21', 2, 'fdfd'),
(75, 20, 2, '2022-11-08 19:43:18', 2, 'pareja'),
(76, 5, 2, '2022-11-08 19:50:44', 2, 'hu'),
(77, 10, 2, '2022-11-08 20:06:20', 2, 'jhjkj'),
(78, 15, 2, '2022-11-08 20:13:17', 2, 'pareja'),
(79, 19, 2, '2022-11-08 20:26:29', 2, 'jovenes'),
(80, 14, 2, '2022-11-08 20:35:56', 2, 'señoras'),
(81, 24, 2, '2022-11-08 20:53:47', 2, 'jovenes'),
(82, 16, 2, '2022-11-08 21:07:07', 2, 'chicas'),
(83, 18, 2, '2022-11-08 21:13:10', 2, 'señoras'),
(84, 6, 2, '2022-11-08 21:17:13', 2, 'gujhgiuj'),
(85, 22, 2, '2022-11-08 21:45:13', 2, 'chicos'),
(86, 1, 2, '2022-11-08 21:45:23', 2, 'silvia'),
(87, 2, 7, '2022-11-08 22:23:17', 2, 'willy'),
(88, 19, 2, '2022-11-09 17:12:24', 2, 'señoras'),
(89, 7, 7, '2022-11-09 18:51:30', 2, 'hhg'),
(90, 24, 2, '2022-11-09 19:36:01', 2, 'pareja'),
(91, 16, 2, '2022-11-09 19:46:36', 2, 'pareja'),
(92, 14, 2, '2022-11-09 19:48:10', 2, 'jovenes'),
(93, 5, 7, '2022-11-09 19:49:21', 2, 'hbvhg'),
(94, 6, 7, '2022-11-09 19:53:56', 2, ' bb'),
(95, 7, 7, '2022-11-09 20:01:21', 2, 'ggg'),
(96, 22, 2, '2022-11-09 20:01:24', 2, 'jovenes'),
(97, 15, 2, '2022-11-09 20:05:29', 2, 'señores'),
(98, 18, 2, '2022-11-09 20:45:49', 2, 'pareja'),
(99, 19, 2, '2022-11-09 21:06:45', 2, 'chicos'),
(100, 14, 2, '2022-11-09 21:14:19', 2, 'mmmm'),
(101, 13, 2, '2022-11-09 21:17:54', 2, 'kkk'),
(102, 8, 7, '2022-11-09 21:22:29', 2, 'pana'),
(103, 15, 2, '2022-11-09 21:25:34', 2, 'kkk'),
(104, 24, 2, '2022-11-09 21:39:33', 2, 'jj'),
(105, 1, 7, '2022-11-10 17:24:33', 2, 'ELIAN'),
(106, 5, 7, '2022-11-10 17:44:37', 2, 'ccccccccccccccccff'),
(107, 10, 7, '2022-11-10 18:01:06', 2, 'tyyy'),
(108, 1, 7, '2022-11-10 18:11:27', 2, 'ENVIO'),
(109, 19, 2, '2022-11-10 18:35:22', 2, 'chicas'),
(110, 15, 2, '2022-11-10 18:47:47', 2, 'lllll'),
(111, 10, 7, '2022-11-10 18:52:31', 2, 'cvcc'),
(112, 6, 7, '2022-11-10 18:57:01', 2, 'ggg'),
(113, 14, 2, '2022-11-10 18:58:26', 2, 'señoras'),
(114, 8, 7, '2022-11-10 19:02:06', 2, 'eee'),
(115, 24, 2, '2022-11-10 19:04:36', 2, 'ñññ'),
(116, 11, 7, '2022-11-10 19:05:53', 2, 'tt'),
(117, 5, 7, '2022-11-10 19:15:45', 2, 'fgffrr'),
(118, 12, 7, '2022-11-10 19:37:19', 2, 'kmkk'),
(119, 8, 7, '2022-11-10 19:50:32', 2, 'gg'),
(120, 22, 2, '2022-11-10 19:50:57', 2, 'llll'),
(121, 24, 2, '2022-11-10 20:03:53', 2, 'kkk'),
(122, 18, 2, '2022-11-10 20:06:59', 2, 'ppp'),
(123, 13, 2, '2022-11-10 20:18:17', 2, 'hhhh'),
(124, 19, 2, '2022-11-10 20:23:15', 2, 'kkk'),
(125, 16, 2, '2022-11-10 20:29:23', 2, 'ggg'),
(126, 23, 2, '2022-11-10 20:42:46', 2, 'jj'),
(127, 10, 7, '2022-11-10 20:47:04', 2, '4r55'),
(128, 6, 7, '2022-11-10 20:49:54', 2, 'ww'),
(129, 9, 7, '2022-11-10 20:55:04', 2, 't66t'),
(130, 1, 7, '2022-11-10 20:55:54', 2, 'orfelinda'),
(131, 19, 2, '2022-11-10 21:04:26', 2, 'll'),
(132, 20, 2, '2022-11-10 21:12:11', 2, 'ññ'),
(133, 5, 7, '2022-11-10 21:38:15', 2, 'hhhhh'),
(134, 13, 2, '2022-11-10 21:41:33', 2, 'jj'),
(135, 23, 2, '2022-11-10 22:06:42', 2, 'll'),
(136, 18, 2, '2022-11-10 22:17:56', 2, 'hhh'),
(137, 6, 7, '2022-11-10 22:22:02', 2, 'gg'),
(138, 5, 2, '2022-11-11 17:49:07', 2, 'vvv'),
(139, 1, 2, '2022-11-11 19:10:17', 2, 'bbbb'),
(140, 19, 2, '2022-11-11 19:17:31', 2, 'ggg'),
(141, 13, 2, '2022-11-11 19:19:40', 2, 'tttt'),
(142, 22, 2, '2022-11-11 19:24:57', 2, 'lll'),
(143, 2, 7, '2022-11-11 19:45:03', 2, 'ENVIO'),
(144, 10, 2, '2022-11-11 19:51:22', 2, '56'),
(145, 5, 2, '2022-11-11 20:10:17', 2, 'hh'),
(146, 9, 2, '2022-11-11 20:24:25', 2, 'tgtt'),
(147, 1, 3, '2022-11-11 20:54:54', 2, 'DEISY'),
(148, 20, 2, '2022-11-11 21:03:30', 2, 'ññññ'),
(149, 1, 3, '2022-11-11 21:07:14', 2, 'ÑÑÑ'),
(150, 6, 2, '2022-11-11 21:19:32', 2, 'ss'),
(151, 15, 2, '2022-11-11 21:20:59', 2, 'kkk'),
(152, 19, 2, '2022-11-11 21:27:27', 2, 'jjj'),
(153, 16, 2, '2022-11-11 21:37:18', 2, 'kkk'),
(154, 14, 9, '2022-11-12 17:47:00', 2, 'kkk'),
(155, 16, 9, '2022-11-12 18:14:10', 2, 'lll'),
(156, 17, 9, '2022-11-12 18:23:27', 2, 'ñññ'),
(157, 19, 9, '2022-11-12 18:27:23', 2, 'll'),
(158, 8, 7, '2022-11-12 18:55:15', 2, 'trtrr'),
(159, 10, 7, '2022-11-12 18:58:26', 2, 'ryt6ujyt'),
(160, 23, 9, '2022-11-12 19:02:09', 2, 'ttt'),
(161, 25, 9, '2022-11-12 19:11:20', 2, 'll'),
(162, 13, 9, '2022-11-12 19:21:52', 2, 'ttt'),
(163, 14, 9, '2022-11-12 19:37:40', 2, 'hhh'),
(164, 18, 9, '2022-11-12 19:44:07', 2, 'ñññ'),
(165, 8, 7, '2022-11-12 20:12:38', 2, 'mesa 4'),
(166, 9, 7, '2022-11-12 20:22:09', 2, 'hgf'),
(167, 20, 9, '2022-11-12 20:25:27', 2, 'll'),
(168, 5, 7, '2022-11-12 20:30:33', 2, 'fytred'),
(169, 13, 9, '2022-11-12 20:47:10', 2, 'lll'),
(170, 17, 9, '2022-11-12 20:52:20', 2, 'kkk'),
(171, 21, 9, '2022-11-12 20:54:14', 3, 'lll'),
(172, 19, 9, '2022-11-12 21:14:53', 2, 'jjj'),
(173, 20, 9, '2022-11-12 22:07:25', 2, 'ññ'),
(174, 10, 2, '2022-11-13 16:47:57', 2, 'ddgfhgf'),
(175, 1, 9, '2022-11-13 17:34:45', 2, 'pasooooo'),
(176, 8, 2, '2022-11-13 17:39:35', 2, 'jjoiiuj'),
(177, 6, 2, '2022-11-13 18:46:16', 2, 'jhfcdfhg'),
(178, 23, 9, '2022-11-13 18:47:10', 2, 'i8ioio'),
(179, 5, 2, '2022-11-13 18:53:27', 2, 'ytytuyt'),
(180, 18, 9, '2022-11-13 18:53:38', 2, 'ioooo'),
(181, 14, 9, '2022-11-13 19:14:18', 2, 'gttt'),
(182, 8, 7, '2022-11-13 19:26:23', 2, 'jhyyuyr'),
(183, 24, 9, '2022-11-13 19:32:49', 3, 'u'),
(184, 24, 9, '2022-11-13 19:32:49', 3, 'u'),
(185, 9, 7, '2022-11-13 19:33:31', 2, 'ttrtrtra'),
(186, 17, 9, '2022-11-13 19:41:01', 2, '666'),
(187, 14, 9, '2022-11-13 20:10:29', 2, 'gg'),
(188, 1, 5, '2022-11-13 20:16:09', 2, 'FESHG'),
(189, 20, 9, '2022-11-13 20:41:35', 2, 'uuu'),
(190, 10, 7, '2022-11-13 20:47:39', 2, 'ggfdgfd'),
(191, 19, 9, '2022-11-13 20:48:50', 2, 'gft'),
(192, 6, 7, '2022-11-13 20:52:24', 2, 'tew5'),
(193, 11, 7, '2022-11-13 21:34:10', 2, 'mmbmn'),
(194, 6, 7, '2022-11-13 21:40:33', 2, 'gfdsgfds'),
(195, 5, 7, '2022-11-13 21:47:03', 2, 'ggfra'),
(196, 16, 9, '2022-11-13 21:54:50', 2, 'yy'),
(197, 19, 9, '2022-11-13 22:21:56', 2, 'hhyh'),
(198, 14, 9, '2022-11-13 22:27:02', 2, 'hgjj'),
(199, 6, 7, '2022-11-14 16:41:43', 2, 'vcbjnnbvc'),
(200, 1, 7, '2022-11-14 16:44:26', 2, 'ENVIO'),
(201, 5, 7, '2022-11-14 16:48:33', 2, 'DDD'),
(202, 9, 7, '2022-11-14 17:35:43', 2, 'ss'),
(203, 10, 7, '2022-11-14 17:38:07', 2, 'e34'),
(204, 1, 5, '2022-11-14 17:39:51', 2, 'ENVIO'),
(205, 19, 9, '2022-11-14 17:50:34', 2, 'ñññ'),
(206, 5, 7, '2022-11-14 18:18:53', 2, 'bb'),
(207, 13, 9, '2022-11-14 18:27:14', 2, 'ttt'),
(208, 8, 7, '2022-11-14 18:44:33', 2, 'y64364w7w654'),
(209, 17, 9, '2022-11-14 18:47:03', 2, 'kkk'),
(210, 15, 9, '2022-11-14 19:04:29', 2, 'uyyyy'),
(211, 23, 9, '2022-11-14 19:09:24', 2, 'hhhhh'),
(212, 6, 7, '2022-11-14 19:13:41', 2, '43434'),
(213, 5, 7, '2022-11-14 19:19:21', 2, 'vcchgg'),
(214, 13, 9, '2022-11-14 19:23:05', 2, 'tt t'),
(215, 20, 9, '2022-11-14 19:35:01', 2, 'kkk'),
(216, 8, 7, '2022-11-14 19:37:11', 2, 'gff'),
(217, 17, 9, '2022-11-14 19:40:30', 2, 'kkkk'),
(218, 18, 9, '2022-11-14 19:43:22', 2, 'llll'),
(219, 7, 7, '2022-11-14 19:52:46', 2, 'GG'),
(220, 19, 9, '2022-11-14 19:56:57', 2, 'ñññ'),
(221, 14, 9, '2022-11-14 20:11:35', 2, 'ñññ'),
(222, 9, 7, '2022-11-14 20:21:43', 2, 'EE'),
(223, 18, 9, '2022-11-14 20:45:35', 2, 'kkk'),
(224, 1, 7, '2022-11-14 20:51:54', 2, 'LLEVAR'),
(225, 12, 7, '2022-11-14 20:58:46', 2, 'W4QW6YTRED'),
(226, 16, 9, '2022-11-14 20:58:48', 2, 'kkk'),
(227, 22, 9, '2022-11-14 21:05:18', 2, 'kkkk'),
(228, 14, 9, '2022-11-14 21:15:33', 2, 'kk'),
(229, 13, 9, '2022-11-14 21:26:10', 2, 'kkk'),
(230, 1, 7, '2022-11-14 21:30:24', 2, 'YTFCUJY7Y'),
(231, 20, 9, '2022-11-14 21:30:44', 2, 'lll'),
(232, 19, 9, '2022-11-14 21:45:43', 2, 'kkk'),
(233, 15, 9, '2022-11-14 21:55:49', 2, 'llll'),
(234, 10, 7, '2022-11-14 22:04:17', 2, 'DDDD'),
(235, 17, 9, '2022-11-14 22:05:28', 2, 'll'),
(236, 6, 7, '2022-11-14 22:17:29', 2, 'YTFDYIJ'),
(237, 17, 9, '2022-11-15 17:32:46', 2, 'lll'),
(238, 20, 9, '2022-11-15 17:38:58', 2, 'ñññ'),
(239, 18, 9, '2022-11-15 17:51:36', 2, 'jjj'),
(240, 8, 7, '2022-11-15 18:07:31', 2, 'nvg m'),
(241, 22, 9, '2022-11-15 18:35:31', 2, 'kkk'),
(242, 14, 9, '2022-11-15 19:02:04', 2, 'kkk'),
(243, 18, 9, '2022-11-15 19:04:14', 2, 'hhh'),
(244, 6, 7, '2022-11-15 19:53:49', 2, 'dsaewgra'),
(245, 8, 7, '2022-11-15 20:06:45', 2, ' xczxzxx'),
(246, 10, 7, '2022-11-15 20:17:18', 2, 'ff'),
(247, 9, 7, '2022-11-15 20:34:17', 2, 'cxcvcxc'),
(248, 5, 7, '2022-11-15 20:35:19', 2, 'vxvbcbvc'),
(249, 1, 7, '2022-11-15 20:52:59', 2, 'hgfg'),
(250, 19, 9, '2022-11-15 20:54:30', 2, 'hhhhh'),
(251, 6, 7, '2022-11-15 20:58:05', 2, 'bgf'),
(252, 13, 9, '2022-11-15 21:06:03', 2, 'ttthff'),
(253, 10, 7, '2022-11-15 21:17:17', 2, 'desedd'),
(254, 5, 7, '2022-11-15 21:33:33', 2, 'xds'),
(255, 10, 7, '2022-11-15 22:02:53', 2, 'rre'),
(256, 6, 7, '2022-11-15 22:25:39', 2, 'gfytrr'),
(257, 9, 7, '2022-11-16 17:46:13', 2, 'saFa'),
(258, 8, 7, '2022-11-16 17:53:05', 2, 'fr54er'),
(259, 1, 3, '2022-11-16 18:00:32', 2, 'dgfjh'),
(260, 2, 3, '2022-11-16 18:08:12', 2, 'ELIAN'),
(261, 10, 7, '2022-11-16 18:18:25', 2, 'olioiuyo'),
(262, 6, 7, '2022-11-16 18:19:12', 2, 'sgfdgdf'),
(263, 5, 7, '2022-11-16 18:22:33', 2, 'ytytytyt'),
(264, 9, 7, '2022-11-16 18:57:52', 2, 'hyjfxgg b '),
(265, 5, 7, '2022-11-16 19:17:42', 2, 'jpoujhy'),
(266, 8, 7, '2022-11-16 19:22:28', 2, 'hgdhcnbv'),
(267, 20, 9, '2022-11-16 19:29:48', 2, 'ñ{ñññ'),
(268, 1, 3, '2022-11-16 19:41:22', 2, 'ENVIO'),
(269, 2, 7, '2022-11-16 19:55:14', 2, 'jhbkjhbkjh'),
(270, 9, 7, '2022-11-16 20:01:46', 2, 'htrr'),
(271, 13, 9, '2022-11-16 20:18:08', 2, 'kk'),
(272, 10, 7, '2022-11-16 20:31:59', 2, 'yttiiuy'),
(273, 23, 9, '2022-11-16 21:08:20', 2, 'kkk'),
(274, 9, 7, '2022-11-16 21:16:24', 2, 'hgfhg'),
(275, 1, 5, '2022-11-16 21:17:13', 2, 'GERFD'),
(276, 19, 9, '2022-11-16 21:34:39', 2, 'kkk'),
(277, 14, 9, '2022-11-16 21:52:03', 2, 'kkk'),
(278, 1, 5, '2022-11-16 21:54:16', 2, 'FXXC'),
(279, 9, 7, '2022-11-16 22:08:43', 2, '7u586'),
(280, 5, 7, '2022-11-16 22:29:06', 2, 'hfchgfdhghgdhgfd'),
(281, 19, 9, '2022-11-17 16:58:23', 2, 'kkk'),
(282, 11, 2, '2022-11-17 17:36:16', 2, 'wefs'),
(283, 14, 9, '2022-11-17 17:51:48', 2, 'jjj'),
(284, 10, 2, '2022-11-17 18:07:06', 2, 'hujgviujhg'),
(285, 20, 9, '2022-11-17 18:32:53', 2, 'iiii'),
(286, 5, 2, '2022-11-17 18:41:03', 2, '4wre'),
(287, 11, 2, '2022-11-17 19:04:15', 2, 'faedsz'),
(288, 9, 2, '2022-11-17 19:12:16', 2, 'utfhgf'),
(289, 8, 2, '2022-11-17 19:16:26', 2, 'hhghgfhgf'),
(290, 22, 9, '2022-11-17 19:28:21', 2, 'jjjj'),
(291, 15, 9, '2022-11-17 19:34:27', 2, 'jjj'),
(292, 10, 2, '2022-11-17 19:37:29', 2, 'ngccv'),
(293, 14, 9, '2022-11-17 19:41:15', 2, 'kkk'),
(294, 20, 9, '2022-11-17 19:56:32', 2, 'ikk'),
(295, 6, 2, '2022-11-17 19:58:31', 2, 'ytfrytfr'),
(296, 8, 2, '2022-11-17 20:05:52', 2, 'grgfgf'),
(297, 19, 9, '2022-11-17 20:21:27', 2, 'kkk'),
(298, 8, 2, '2022-11-17 20:22:21', 2, 'tyuj'),
(299, 13, 9, '2022-11-17 20:41:08', 2, 'kkk'),
(300, 16, 9, '2022-11-17 20:49:11', 2, 'kkk'),
(301, 20, 9, '2022-11-17 21:08:50', 2, 'kkk'),
(302, 7, 2, '2022-11-17 21:20:36', 2, 'gzrsgfdr'),
(303, 9, 2, '2022-11-17 21:53:51', 2, 'hfdhgfdx'),
(304, 10, 2, '2022-11-17 22:00:52', 2, 'ggfrfds'),
(305, 23, 9, '2022-11-17 22:01:19', 2, 'lll'),
(306, 19, 9, '2022-11-17 22:05:03', 2, 'jj'),
(307, 1, 3, '2022-11-18 16:50:52', 2, 'DASAS'),
(308, 10, 2, '2022-11-18 17:27:45', 2, 'm'),
(309, 23, 9, '2022-11-18 17:28:48', 2, 'lll'),
(310, 19, 9, '2022-11-18 17:29:58', 2, 'llll'),
(311, 13, 9, '2022-11-18 17:46:48', 2, 'kkk'),
(312, 15, 9, '2022-11-18 18:19:32', 2, 'kkk'),
(313, 8, 2, '2022-11-18 18:26:07', 2, '6525432432'),
(314, 1, 5, '2022-11-18 18:31:57', 2, 'DFGF'),
(315, 10, 2, '2022-11-18 18:47:39', 2, 'ewwwwewr'),
(316, 19, 9, '2022-11-18 18:53:55', 2, 'kkk'),
(317, 17, 9, '2022-11-18 18:56:17', 2, 'lll'),
(318, 14, 9, '2022-11-18 19:14:45', 2, 'kkk'),
(319, 1, 5, '2022-11-18 19:15:03', 2, 'DEWSGFDHGDF'),
(320, 13, 9, '2022-11-18 19:44:38', 2, 'jjj'),
(321, 10, 2, '2022-11-18 19:58:04', 2, 'fgfffdwgtERYGHHG'),
(322, 20, 9, '2022-11-18 19:59:59', 2, 'hhhh'),
(323, 5, 2, '2022-11-18 20:04:20', 2, 'WETTQ'),
(324, 6, 2, '2022-11-18 20:04:48', 2, 'URER'),
(325, 17, 9, '2022-11-18 20:16:13', 2, 'lll'),
(326, 9, 2, '2022-11-18 20:18:23', 2, 'WRW'),
(327, 8, 2, '2022-11-18 20:26:26', 2, 'Q'),
(328, 18, 9, '2022-11-18 20:40:24', 2, 'kkk'),
(329, 6, 2, '2022-11-18 20:45:06', 2, 'hfdrujhtruter'),
(330, 10, 2, '2022-11-18 21:07:49', 2, 'ujdjtr'),
(331, 19, 9, '2022-11-18 21:10:50', 2, 'kkk'),
(332, 15, 9, '2022-11-18 21:13:05', 2, 'lll'),
(333, 13, 9, '2022-11-18 21:28:15', 2, 'hjhgfjhg'),
(334, 1, 2, '2022-11-18 21:31:24', 2, 'ouiuyg'),
(335, 9, 2, '2022-11-18 21:36:52', 2, 'rrw'),
(336, 14, 9, '2022-11-18 21:41:17', 2, 'kk'),
(337, 5, 2, '2022-11-18 21:53:43', 2, 'ytrytruytr'),
(338, 9, 2, '2022-11-18 22:17:17', 2, 'teererery'),
(339, 19, 9, '2022-11-18 22:28:06', 2, 'jjj'),
(340, 18, 9, '2022-11-18 22:28:39', 2, 'jhgjh'),
(342, 1, 2, '2022-11-25 10:02:28', 1, 'JORGE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id` int NOT NULL,
  `nombre` varchar(75) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `descripcion` text NOT NULL,
  `estado` int NOT NULL DEFAULT '1',
  `id_categoria` int NOT NULL,
  `foto` varchar(255) NOT NULL DEFAULT 'defecto.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id`, `nombre`, `precio`, `descripcion`, `estado`, `id_categoria`, `foto`) VALUES
(91, 'RISTRETO', '5.50', 'ESENCIA', 1, 5, 'defecto.jpg'),
(92, 'ESPRESSO', '5.50', 'ESENCIa', 1, 5, 'defecto.jpg'),
(93, 'ESPRESSO LARGO O LUNGO', '5.50', 'ESENCIA', 1, 5, 'defecto.jpg'),
(94, 'AMERICANO KIDS', '6.00', 'ESENCIA MAS AGUA', 1, 5, 'defecto.jpg'),
(95, 'AMERICANO GRANDE', '7.50', 'ESENCIA MAS AGUA', 1, 5, 'defecto.jpg'),
(96, 'ESPRESSO ROMANO', '6.00', 'ESENCIA MAS CAFÉ', 1, 5, 'defecto.jpg'),
(97, 'XXX', '1.00', 'C', 1, 5, 'defecto.jpg'),
(98, 'CAPUCCHINO KIDS', '7.50', 'ESPRESSO CON CREMA DE LECHE', 1, 5, 'defecto.jpg'),
(99, 'CAPUCCHINO ', '9.50', 'ESPRESSO CON CREMA DE LECHE', 1, 5, 'defecto.jpg'),
(100, 'CORTADO', '7.50', 'ESPRESO CON CHORRO DE LECHE', 1, 5, 'defecto.jpg'),
(101, 'ESPRESSO DOBLE', '7.50', 'ESPRESO DOBLE', 1, 5, 'defecto.jpg'),
(102, 'MACCHIATO', '7.50', 'ESPRESO , ESPUMA DE LECHE Y CANELA', 1, 5, 'defecto.jpg'),
(103, 'LATTE', '12.00', 'COON DISEÑO PERSONALIZADO', 1, 5, 'defecto.jpg'),
(104, 'BOMBOM', '8.00', 'ESPRESSO Y LECHE CONDENSADA', 1, 5, 'defecto.jpg'),
(105, 'AMERICANO CON ESPRESSO DOBLE', '9.00', 'AMERICANO CARGADO', 1, 5, 'defecto.jpg'),
(106, 'PRENSA FRANCESA KIDS', '9.50', 'METODO DE EXTRACCION PARA 2 PERSONAS', 1, 5, 'defecto.jpg'),
(107, 'PRENSA FRANCESA', '13.00', 'METODO DE EXTRACCION PARA 4 PERSONAS', 1, 5, 'defecto.jpg'),
(108, 'AFOGATO', '13.00', 'ESPRESSO DOBLE Y 2 BOLAS DE HELADO', 1, 5, 'defecto.jpg'),
(109, 'V60 KIDS', '15.00', 'FILRADO DE CAFÉ CON CONO DE PAPEL VECTOR 60 ', 1, 5, 'defecto.jpg'),
(110, 'V60', '20.00', 'CAFE FILTRADO EN CONO DE PAPEL VECTOR 60, PARA 4 PERSONAS', 1, 5, 'defecto.jpg'),
(111, 'CHEMEX KIDS', '16.00', 'X', 1, 5, 'defecto.jpg'),
(112, 'CHEMEX ', '22.00', 'PARA 4 PERSONAS', 1, 5, 'defecto.jpg'),
(113, 'GOTA A GOTA KIDS', '18.00', 'X', 1, 5, 'defecto.jpg'),
(114, 'GOTA A GOTA', '24.00', 'PARA 4 PERSONAS', 1, 5, 'defecto.jpg'),
(115, 'CHOCOLATE  KIDS', '6.50', '100 POR CIENTO CACAO', 1, 5, 'defecto.jpg'),
(116, 'CHOCOLATE', '8.50', 'TAZA GRANDE', 1, 5, 'defecto.jpg'),
(117, 'CHOCOPUCHINO KIDS', '8.00', 'CHOCOLATE CON LECHE EMULCIONADA', 1, 5, 'defecto.jpg'),
(118, 'CHOCOPUCHINO ', '10.00', 'TAZA GRANDE', 1, 5, 'defecto.jpg'),
(119, 'INFUSION DE PEREJIL MAS LIMON', '5.00', 'X', 1, 22, 'defecto.jpg'),
(120, 'INFUSION DE EUCALIPTO MAS LIMON Y MIEL', '7.00', 'X', 1, 22, 'defecto.jpg'),
(121, 'INFUSION DE KION MATICO LIMON Y MIEL', '9.00', 'X', 1, 22, 'defecto.jpg'),
(122, 'ESPRESATE', '12.00', 'FREPE DE CAFE', 1, 15, 'defecto.jpg'),
(123, 'FRESCA FELICIDAD', '13.00', 'FRAPE DE CAFE CON CHOCOLATE Y MENTA', 1, 15, 'defecto.jpg'),
(124, 'GELATO', '16.00', 'FRAPEE DE CAFE CON HELADO DE VAINILLA Y CHOCOLATE', 1, 15, 'defecto.jpg'),
(125, 'ANDINO', '18.00', 'FRAPPE EN BASE A MASCHA  Y CAFE', 1, 15, 'defecto.jpg'),
(126, 'HANSEL Y GRETEL', '13.00', 'Frappe de chocolate', 1, 15, 'defecto.jpg'),
(127, 'ORIANA ', '11.50', 'FRAPEE DE OREO', 1, 15, 'defecto.jpg'),
(128, 'COLORIN', '15.00', 'FRAPPE CON CHICHIN', 1, 15, 'defecto.jpg'),
(129, 'FRAPPE DE MANGO', '13.00', 'X', 1, 15, 'defecto.jpg'),
(130, 'FRAPPE DE NARANJILLA', '13.00', 'X', 1, 15, 'defecto.jpg'),
(131, 'FRAPPE DE BERENJENA', '13.00', 'X', 1, 15, 'defecto.jpg'),
(132, 'FRAPPE DE LUCUMA', '14.00', 'X', 1, 15, 'defecto.jpg'),
(133, 'MARACUYA', '14.00', 'X', 1, 15, 'defecto.jpg'),
(134, 'FRAPPE DE FRESA', '14.00', 'X', 1, 15, 'defecto.jpg'),
(135, 'FRAPPE DE FRUTOS SECOS', '17.00', 'X', 1, 15, 'defecto.jpg'),
(136, 'AGUA DE PEPINILLO', '3.00', 'X', 1, 16, 'defecto.jpg'),
(137, 'HIERBA LUISA  FRESH', '6.00', 'REFRESCANTE', 1, 16, 'defecto.jpg'),
(138, 'LIMON Y HIERBA BUENA', '6.50', 'REFRESCANTE DE LIMON CON TOQUES A HIERBA BUENA', 1, 16, 'defecto.jpg'),
(139, 'NARANJILLA FRESH', '7.50', 'REFRESCANTE DE NARANJILLA', 1, 16, 'defecto.jpg'),
(140, 'NARANJA Y MENTA FRESH', '7.50', 'REFRESCANTE', 1, 16, 'defecto.jpg'),
(141, 'PIÑA Y HIERBA LUISA FRESH', '7.50', 'REFRESCANTE', 1, 16, 'defecto.jpg'),
(142, 'CHIBOLO POWER', '9.00', 'ESPRESSO, NARANJA Y MALTIN', 1, 16, 'defecto.jpg'),
(143, 'BABACO', '9.00', 'REFRESCANTE', 1, 16, 'defecto.jpg'),
(144, 'MARACUYA FRESH', '9.00', 'X', 1, 16, 'defecto.jpg'),
(145, 'UVA FRESH', '10.00', 'REFRESCANTE', 1, 5, 'defecto.jpg'),
(146, 'AGUA SAN LUIS CON GAS', '3.00', 'X', 1, 12, 'defecto.jpg'),
(147, 'AGUA SAN LUIS SIN GAS', '3.00', 'X', 1, 12, 'defecto.jpg'),
(148, 'COCA COLA', '5.00', 'X', 1, 12, 'defecto.jpg'),
(149, 'FANTA', '4.00', 'X', 1, 12, 'defecto.jpg'),
(150, 'INKA KOLA', '5.00', 'X', 1, 12, 'defecto.jpg'),
(151, 'AGUARDIENTE', '7.00', 'X', 1, 8, 'defecto.jpg'),
(152, 'VINO COPA', '11.00', 'X', 1, 8, 'defecto.jpg'),
(153, 'INFILTRADO', '11.00', 'X', 1, 8, 'defecto.jpg'),
(154, 'ANDINITO', '11.00', 'X', 1, 8, 'defecto.jpg'),
(155, 'ROMPOPE', '11.00', 'X', 1, 8, 'defecto.jpg'),
(156, 'CHILCANO CLASICO', '13.00', 'X', 1, 8, 'defecto.jpg'),
(157, 'CHILCANO DE NARANJILLA', '13.00', 'X', 1, 8, 'defecto.jpg'),
(158, 'CHILCANO DE BERENJENA', '13.00', 'X', 1, 8, 'defecto.jpg'),
(159, 'CHILCANO DE MARACUYA', '13.00', 'X', 1, 8, 'defecto.jpg'),
(160, 'CHILCANO DE MANGO', '13.00', 'X', 1, 8, 'defecto.jpg'),
(161, 'CHILCANO DE FRESA', '13.00', 'X', 1, 8, 'defecto.jpg'),
(162, 'CUBA LIBRE', '13.00', 'RON RUBIO Y COCA COLA', 1, 8, 'defecto.jpg'),
(163, 'MOJITO', '13.00', 'RON BLANCO Y HIERBA BUENA', 1, 8, 'defecto.jpg'),
(164, 'PISCO SOUR', '15.00', 'X', 1, 8, 'defecto.jpg'),
(165, 'TINTO DE VERANO ', '15.00', 'X', 1, 8, 'defecto.jpg'),
(166, 'CHOLO POWER', '15.00', 'ESPRESO Y CERVEZA NEGRA', 1, 8, 'defecto.jpg'),
(167, 'COCTEL DE ALGARROBINA', '17.00', 'PISCO Y ALGARROBINA CON LECHE', 1, 8, 'defecto.jpg'),
(168, 'CHAMPAGNE RICADONA  BOTELLA ', '90.00', 'X', 1, 12, 'defecto.jpg'),
(169, 'VINO AMORE DE ICA', '60.00', 'SEMI SECO', 1, 12, 'defecto.jpg'),
(170, 'TABERNERO ROSE SEMI SECO', '60.00', 'X', 1, 12, 'defecto.jpg'),
(171, 'VINO NAVARRO CORREA', '90.00', 'VINO SECO', 1, 12, 'defecto.jpg'),
(172, 'VINO INTIPALKA SECO', '90.00', 'VINO SECO', 1, 12, 'defecto.jpg'),
(173, 'PILSEN ', '7.00', 'X', 1, 12, 'defecto.jpg'),
(174, 'CUZQUEÑA TRIGO ', '8.00', 'X', 1, 12, 'defecto.jpg'),
(175, 'CUSQUEÑA DORADA', '8.00', 'X', 1, 12, 'defecto.jpg'),
(176, 'CUSQUEÑA ROJA', '8.00', 'X', 1, 12, 'defecto.jpg'),
(177, 'CUSQUEÑA NEGRA', '8.50', 'X', 1, 12, 'defecto.jpg'),
(178, 'CUSQUEÑA DOBLE MALTA', '8.50', 'X', 1, 12, 'defecto.jpg'),
(179, 'CORONA', '11.00', 'X', 1, 12, 'defecto.jpg'),
(180, 'ARTESANAL BRAUER CAFE', '17.00', 'ENKA 47', 1, 12, 'defecto.jpg'),
(181, 'ARTESANAL BRAUER MIEL', '17.00', 'X', 1, 12, 'defecto.jpg'),
(182, 'ARTESANAL BRAUER RED ALE', '17.00', 'X', 1, 12, 'defecto.jpg'),
(183, 'BARBARIAN  QUINUA ', '16.00', 'ARTESANAL', 1, 12, 'defecto.jpg'),
(184, 'BARBARIAN LIMA PALE ALE', '16.00', 'ARTESANAL', 1, 12, 'defecto.jpg'),
(185, 'BARBARIAN LA NENA', '16.00', 'ARTESANAL', 1, 12, 'defecto.jpg'),
(186, 'MALQUERIDA RED ALE', '18.00', 'X', 1, 12, 'defecto.jpg'),
(187, 'MALQUERIDA  MARACUMANGO CERVEZA ARTESANAL', '18.00', 'ARTESANAL', 1, 12, 'defecto.jpg'),
(188, 'MALQUERIDA MANZANA CERVEZA ARTESANAL', '18.00', 'CERVEZA ARTESANAL', 1, 12, 'defecto.jpg'),
(189, 'MALQUERIDA CAFE CERVEZA ARTESANAL', '18.00', 'X', 1, 12, 'defecto.jpg'),
(190, 'JARRA DE NARANJILLA  FRESH', '19.50', 'X', 1, 5, 'defecto.jpg'),
(191, 'JARRA DE NARANJA FRESH', '19.50', 'X', 1, 5, 'defecto.jpg'),
(192, 'JARRA LIMONADA FRESH', '19.50', 'X', 1, 5, 'defecto.jpg'),
(193, 'JARRA DE MARACUYA FRESH', '20.00', 'X', 1, 5, 'defecto.jpg'),
(194, 'JARRA DE BABACO ', '21.00', 'X', 1, 5, 'defecto.jpg'),
(195, 'TAZA DE LECHE CALIENTE ', '6.00', 'EMULSIONADA', 1, 5, 'defecto.jpg'),
(196, 'TAZA KIDS DE LECHE EVAPORADA', '6.00', 'LECHE DE TARRO', 1, 5, 'defecto.jpg'),
(197, 'XX', '1.00', 'X', 1, 5, 'defecto.jpg'),
(198, 'EMPANADA DE QUESO', '11.00', 'SUIZO Y BLANCO', 1, 13, 'defecto.jpg'),
(199, 'EMPANADA DE CARNE', '11.00', 'C', 1, 13, 'defecto.jpg'),
(200, 'EMPANADAS DE CHAMPIÑONES', '13.00', 'X', 1, 13, 'defecto.jpg'),
(201, 'EMPANADA DE HUAMBRILLA', '16.00', 'CECNINA, CHORIZO, PLATANOS, HUEVOS', 1, 13, 'defecto.jpg'),
(202, 'ENSALADA DE LA CASA KIDS', '6.00', 'PERSONAL', 1, 13, 'defecto.jpg'),
(203, 'ENSALADA DE LA CASA GRANDE', '10.00', 'X', 1, 13, 'defecto.jpg'),
(204, 'SANDWICH QUESO BLANCO', '5.00', 'QUESO BLANCO', 1, 13, 'defecto.jpg'),
(205, 'SANDWICH QUESO SUIZO', '7.00', 'X', 1, 13, 'defecto.jpg'),
(206, 'SANDWICH DE POLLO CLASICO', '7.50', 'TOMATE, LECHUGA, POLLO', 1, 13, 'defecto.jpg'),
(207, 'SANDWICH POLLO CON DURAZNO', '9.00', 'X', 1, 13, 'defecto.jpg'),
(208, 'SANDWICH DE CHANCHITO', '9.50', 'CERDO CON SARZA', 1, 13, 'defecto.jpg'),
(209, 'SANDWICH DE PAVO', '10.00', 'X', 1, 13, 'defecto.jpg'),
(210, 'TRIPLE AMERICANO', '11.00', 'PAN DE MOLDE, HUEVO, PALTA Y TOMATE Y MAYONESA', 1, 13, 'defecto.jpg'),
(211, 'TRIPLE VEGETARIANO', '11.00', 'QUESO BLANCO, ESPINACA, HUEVO, TOMATE Y MAYONESA', 1, 13, 'defecto.jpg'),
(212, 'SANDWICH LITE', '11.50', 'PAN INTEGRAL- QUESO PASTURIZADO Y JAMON DE PAVITA', 1, 13, 'defecto.jpg'),
(213, 'TRIPLE HAWAIANO ', '13.00', 'DURAZNO, JAMON Y QUESO EDAM ', 1, 13, 'defecto.jpg'),
(214, 'TRIPLE TURISTA', '15.00', 'POLLO, DURAZNO, JAMON, , QUESO EDAM Y TOCINO', 1, 13, 'defecto.jpg'),
(215, 'CHOCLITO  FRITO CON QUESO ', '8.00', '1 CHOCLO', 1, 13, 'defecto.jpg'),
(216, 'CHOCLITO SANCOCHADO CON QUESO', '8.00', '1 CHOLCLO', 1, 13, 'defecto.jpg'),
(217, 'CALDO DE PAICO', '11.00', 'X', 1, 13, 'defecto.jpg'),
(218, 'DESAYUNO VEGETARIANO', '16.00', 'CAFE AMERICANO, YUCA, CAMOTE, TORTILLA DE VERDURAS', 1, 13, 'defecto.jpg'),
(219, 'DESAYUNO AMERICANO', '18.00', 'CAFE AMERICANO, JUGO DE NARANJA, TOSTADAS, HUEVO REVUELTO Y TOCINO', 1, 13, 'defecto.jpg'),
(220, 'DESAYUNO CAMPESINO', '19.50', 'CAFE A LA OLLA, YUCA, RECACHA, BITUCA, QUESO BLANCO Y HUEVOS DUROS', 1, 13, 'defecto.jpg'),
(221, 'LIVIANO FRITO', '9.50', '1 PLATANO', 1, 13, 'defecto.jpg'),
(222, 'LIVIANO SANCOCHADO', '9.50', '1.5 PLATANOS', 1, 13, 'defecto.jpg'),
(223, 'ENRROLLADO DE AVENA CON QUESO', '15.00', 'X', 1, 13, 'defecto.jpg'),
(224, 'ENRROLLADO DE AVENA CON  POLLO', '15.00', 'X', 1, 13, 'defecto.jpg'),
(225, 'CEJA DE SELVA', '18.00', 'CECINA O CHORIZO Y 2 HUMITAS', 1, 13, 'defecto.jpg'),
(226, 'CHICHARRON DE CHANCHO', '20.50', 'MAJOTE, 3 CHICHARROS, SARZA', 1, 13, 'defecto.jpg'),
(227, 'LONCHE SERRANO', '21.00', 'TAMALES CON CHICHARRON DE CERDO', 1, 13, 'defecto.jpg'),
(228, 'GALLINA  CON RECETA TRADICIONAL DE LA ABUELA', '30.00', 'GALLINA, MAJOTE, BITUCA Y PLATANO Y CREMA DE GUACATAY', 1, 13, 'defecto.jpg'),
(229, 'BITUCA', '3.00', 'SANCOCHADA', 1, 7, 'defecto.jpg'),
(230, 'BITUCA CHANCADA', '7.00', 'X', 1, 7, 'defecto.jpg'),
(231, 'RECACHA', '3.00', 'SANCOCHADA', 1, 7, 'defecto.jpg'),
(232, 'YUCAS', '3.00', 'SANCOCHADA', 1, 7, 'defecto.jpg'),
(233, 'SARZA', '5.00', 'CEBOLLA', 1, 7, 'defecto.jpg'),
(234, 'HUEVOS DUROS', '6.00', '2 HUEVOS SANCOCHADOS', 1, 7, 'defecto.jpg'),
(235, 'PLATANOS FRITOS', '6.00', 'MADUROS', 1, 7, 'defecto.jpg'),
(236, 'MAJOTE', '7.00', 'DE PALILLO', 1, 7, 'defecto.jpg'),
(237, 'PANQUEQUE DE MANJAR', '6.00', 'X', 1, 10, 'defecto.jpg'),
(238, 'PANQUEQUE ESPECIAL', '15.00', 'CON FRUTAS Y HELADO', 1, 10, 'defecto.jpg'),
(239, 'KEKE DE CHOCOLATE', '7.50', 'X', 1, 6, 'defecto.jpg'),
(240, 'POSTRE DEL DIA ', '8.00', 'PREGUNTAR', 1, 10, 'defecto.jpg'),
(241, 'CHIUCHE', '8.00', 'X', 1, 10, 'defecto.jpg'),
(242, 'QUESILLO CON MIEL', '9.00', 'X', 1, 10, 'defecto.jpg'),
(243, 'ACEITUNAS VERDES', '9.00', 'X', 1, 14, 'defecto.jpg'),
(244, 'MIX FRUTOS SECOS', '11.00', 'X', 1, 14, 'defecto.jpg'),
(245, 'TEQUEÑOS', '17.00', 'DE QUESO Y JAMON', 1, 14, 'defecto.jpg'),
(246, 'FUENTE DE CHICHARRON DE CHANCHO ', '40.00', 'PLATANOS FRITOS CON CHICHARRONES', 1, 14, 'defecto.jpg'),
(247, 'GALLETAS DE CAFE', '1.00', 'X', 1, 6, 'defecto.jpg'),
(248, 'BRAWNIE', '7.00', 'X', 1, 6, 'defecto.jpg'),
(249, 'KEKE DE CAFE', '7.00', 'X', 1, 6, 'defecto.jpg'),
(250, 'CAFE A LA OLLA', '7.00', 'X', 1, 18, 'defecto.jpg'),
(251, 'CAFE FRESH', '8.00', 'AMERICANO REFRESCANTE', 1, 16, 'defecto.jpg'),
(252, 'CAFE HELADO', '11.00', 'CAFE CON LECHE FRIO O HELADO', 1, 16, 'defecto.jpg'),
(253, 'HUMITA', '5.00', 'DE CHOCLO CON QUESO', 1, 7, 'defecto.jpg'),
(254, 'TAMAL', '5.00', 'DE QUESO', 1, 7, 'defecto.jpg'),
(255, 'TAPER BIODEGRADABLE', '1.50', 'PARA GALLINA , CHICHARRON, PANQ. ESPECIAL', 1, 20, 'defecto.jpg'),
(256, 'CAJA BIODEGRADABLE', '1.00', 'EMPANADAS, PANQ MAJAR, HUMITAS, Y TRIPLES', 1, 20, 'defecto.jpg'),
(257, 'VASO DOMO', '1.00', 'FRAPES Y REFRESCANTES', 1, 19, 'defecto.jpg'),
(258, 'VASO POLIPAPEL CALIENTE', '1.00', 'CAFES CALIENTES ETC', 1, 19, 'defecto.jpg'),
(259, 'HELADO', '3.50', '1 BOLA ', 1, 13, 'defecto.jpg'),
(260, 'MANZANILLA', '3.00', 'X', 1, 21, 'defecto.jpg'),
(261, 'HIERBA LUISA', '3.00', 'X', 1, 21, 'defecto.jpg'),
(262, 'MENTA', '3.00', 'X', 1, 21, 'defecto.jpg'),
(263, 'ANIS', '3.00', 'X', 1, 21, 'defecto.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promocion_bonus`
--

CREATE TABLE `promocion_bonus` (
  `id` int NOT NULL,
  `ticket` varchar(32) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `porcentaje` decimal(6,2) NOT NULL,
  `estado` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `promocion_bonus`
--

INSERT INTO `promocion_bonus` (`id`, `ticket`, `nombre`, `fecha_inicio`, `fecha_fin`, `porcentaje`, `estado`) VALUES
(1, 'XYZABC2019', 'ws', '2019-01-01', '2019-04-04', '20.00', 1),
(2, 'MARZO', 'EMPANADA Y CAFÉ AMERICANO', '2022-11-01', '2022-11-30', '10.00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promocion_puntos`
--

CREATE TABLE `promocion_puntos` (
  `id` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad_puntos` int NOT NULL,
  `cantidad_producto` int NOT NULL,
  `estado` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `promocion_puntos`
--

INSERT INTO `promocion_puntos` (`id`, `id_producto`, `cantidad_puntos`, `cantidad_producto`, `estado`) VALUES
(1, 1, 25, 1, 1),
(2, 1, 70, 2, 1),
(3, 1, 100, 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `serie_comprobante`
--

CREATE TABLE `serie_comprobante` (
  `id` int NOT NULL,
  `id_tipo_comprobante` char(2) NOT NULL,
  `numero` int NOT NULL,
  `correlativo` int NOT NULL DEFAULT '1',
  `estado` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `serie_comprobante`
--

INSERT INTO `serie_comprobante` (`id`, `id_tipo_comprobante`, `numero`, `correlativo`, `estado`) VALUES
(1, '01', 1, 4, 1),
(2, '01', 2, 1, 1),
(3, '02', 1, 355, 1),
(4, '02', 2, 1, 1),
(5, '03', 1, 1, 1),
(6, '04', 2, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_comprobante`
--

CREATE TABLE `tipo_comprobante` (
  `id` char(2) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `abreviatura` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_comprobante`
--

INSERT INTO `tipo_comprobante` (`id`, `nombre`, `abreviatura`) VALUES
('01', 'TICKET', 'TK'),
('02', 'BOLETA', 'BO'),
('03', 'FACTURA', 'FA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_empleado`
--

CREATE TABLE `tipo_empleado` (
  `id` int NOT NULL,
  `descripcion` varchar(75) NOT NULL,
  `estado` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_empleado`
--

INSERT INTO `tipo_empleado` (`id`, `descripcion`, `estado`) VALUES
(1, 'ADMINISTRADOR', 1),
(2, 'MESERO', 1),
(3, 'CAJERO', 1),
(4, 'COCINA', 1),
(5, 'BAR', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_servicio`
--

CREATE TABLE `tipo_servicio` (
  `id` int NOT NULL,
  `nombre` varchar(75) NOT NULL,
  `estado` int NOT NULL DEFAULT '1',
  `abreviatura` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_servicio`
--

INSERT INTO `tipo_servicio` (`id`, `nombre`, `estado`, `abreviatura`) VALUES
(1, 'BAR', 1, 'BA'),
(2, 'COCINA', 1, 'CO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `toma_pedido`
--

CREATE TABLE `toma_pedido` (
  `id` int NOT NULL,
  `id_pedido` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `estado` int NOT NULL DEFAULT '1',
  `nota` text,
  `kpi` text,
  `observaciones` text,
  `item` int NOT NULL,
  `timbre` int NOT NULL DEFAULT '1',
  `id_facturacion` int DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `descuento` decimal(16,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `toma_pedido`
--

INSERT INTO `toma_pedido` (`id`, `id_pedido`, `id_producto`, `cantidad`, `precio`, `estado`, `nota`, `kpi`, `observaciones`, `item`, `timbre`, `id_facturacion`, `fecha_registro`, `descuento`) VALUES
(37, 11, 234, 1, '6.00', 6, NULL, '00:36', NULL, 6, 0, 7, '2022-11-07 15:58:44', '0.00'),
(38, 11, 215, 1, '8.00', 6, NULL, '00:40', NULL, 18, 0, 7, '2022-11-07 15:58:44', '0.00'),
(39, 11, 99, 1, '9.50', 6, NULL, '01:12', NULL, 9, 0, 7, '2022-11-07 15:58:44', '0.00'),
(40, 12, 204, 1, '5.00', 6, NULL, '00:26', NULL, 7, 0, 8, '2022-11-07 16:02:53', '0.00'),
(41, 12, 209, 2, '10.00', 6, NULL, '00:28', NULL, 12, 0, 8, '2022-11-07 16:02:53', '0.00'),
(42, 12, 222, 1, '9.50', 6, NULL, '00:30', NULL, 25, 0, 8, '2022-11-07 16:02:53', '0.00'),
(43, 12, 95, 1, '7.50', 6, NULL, '00:11', NULL, 5, 0, 8, '2022-11-07 16:02:53', '0.00'),
(44, 13, 225, 2, '18.00', 6, NULL, '00:24', NULL, 28, 0, 9, '2022-11-07 16:05:32', '0.00'),
(45, 13, 99, 1, '9.50', 6, NULL, '00:28', NULL, 9, 0, 9, '2022-11-07 16:05:32', '0.00'),
(46, 13, 118, 1, '24.00', 6, NULL, '00:36', NULL, 28, 0, 9, '2022-11-07 16:05:32', '0.00'),
(47, 14, 97, 2, '7.00', 6, NULL, '05:03', NULL, 7, 0, 10, '2022-11-07 16:07:28', '0.00'),
(48, 15, 226, 2, '20.50', 6, NULL, '00:19', NULL, 29, 0, 11, '2022-11-07 16:08:21', '0.00'),
(49, 15, 99, 2, '9.50', 6, NULL, '04:21', NULL, 9, 0, 11, '2022-11-07 16:08:21', '0.00'),
(50, 16, 95, 1, '7.50', 6, NULL, '02:09', NULL, 5, 0, 12, '2022-11-07 16:10:38', '0.00'),
(51, 16, 140, 1, '7.50', 6, NULL, '02:14', NULL, 5, 0, 12, '2022-11-07 16:10:38', '0.00'),
(52, 17, 217, 1, '11.00', 6, NULL, '00:20', NULL, 20, 0, 13, '2022-11-07 16:12:10', '0.00'),
(53, 17, 218, 2, '16.00', 6, NULL, '00:16', NULL, 21, 0, 13, '2022-11-07 16:12:10', '0.00'),
(54, 17, 140, 2, '7.50', 6, NULL, '00:48', NULL, 5, 0, 13, '2022-11-07 16:12:10', '0.00'),
(55, 18, 97, 2, '7.00', 6, NULL, '04:51', NULL, 7, 0, 14, '2022-11-07 16:12:57', '0.00'),
(56, 19, 240, 2, '8.00', 6, NULL, '00:20', NULL, 3, 0, 15, '2022-11-07 16:14:08', '0.00'),
(57, 19, 97, 2, '7.00', 6, NULL, '02:05', NULL, 7, 0, 15, '2022-11-07 16:14:08', '0.00'),
(58, 19, 239, 2, '7.50', 6, NULL, '02:07', NULL, 1, 0, 15, '2022-11-07 16:15:00', '0.00'),
(59, 19, 247, 2, '1.00', 6, NULL, '02:02', NULL, 2, 0, 15, '2022-11-07 16:15:00', '0.00'),
(60, 20, 149, 1, '4.00', 6, NULL, '01:09', NULL, 4, 0, 16, '2022-11-07 16:15:41', '0.00'),
(61, 0, 198, 1, '11.00', 4, NULL, NULL, NULL, 1, 1, NULL, '2022-11-07 16:21:45', '0.00'),
(62, 0, 99, 1, '9.50', 4, NULL, NULL, NULL, 9, 1, NULL, '2022-11-07 16:21:45', '0.00'),
(63, 16, 92, 6, '5.50', 6, NULL, '13:38', NULL, 2, 0, 12, '2022-11-07 16:22:16', '0.00'),
(64, 17, 100, 1, '7.00', 6, NULL, '12:13', NULL, 10, 0, 13, '2022-11-07 16:22:53', '0.00'),
(65, 16, 104, 1, '8.00', 6, NULL, '13:49', NULL, 14, 0, 12, '2022-11-07 16:23:42', '0.00'),
(66, 21, 237, 3, '6.00', 6, NULL, '00:20', NULL, 1, 0, 18, '2022-11-07 16:27:32', '0.00'),
(67, 21, 139, 1, '7.00', 6, NULL, '03:21', NULL, 4, 0, 18, '2022-11-07 16:27:32', '0.00'),
(68, 22, 204, 2, '5.00', 6, NULL, '00:27', NULL, 7, 0, 17, '2022-11-07 16:29:31', '0.00'),
(69, 23, 242, 1, '9.00', 6, NULL, '01:18', NULL, 5, 0, 19, '2022-11-07 17:03:32', '0.00'),
(70, 23, 225, 2, '18.00', 6, NULL, '01:23', NULL, 28, 0, 19, '2022-11-07 17:03:32', '0.00'),
(71, 23, 250, 2, '7.00', 6, NULL, '01:28', NULL, 1, 0, 19, '2022-11-07 17:03:32', '0.00'),
(72, 23, 109, 1, '15.00', 6, NULL, '00:13', NULL, 19, 0, 19, '2022-11-07 17:03:32', '0.00'),
(73, 23, 192, 1, '19.50', 6, NULL, '00:24', NULL, 35, 0, 19, '2022-11-07 17:03:32', '0.00'),
(74, 23, 248, 1, '7.00', 6, NULL, '00:32', NULL, 3, 0, 19, '2022-11-07 17:03:32', '0.00'),
(75, 23, 173, 1, '7.00', 6, NULL, '01:04', NULL, 11, 0, 19, '2022-11-07 17:03:32', '0.00'),
(76, 24, 199, 1, '11.00', 6, NULL, '00:44', NULL, 2, 0, 24, '2022-11-07 17:05:58', '0.00'),
(77, 24, 159, 1, '13.00', 6, NULL, '03:30', 'deja de rascarte la pachara', 9, 0, 24, '2022-11-07 17:05:58', '0.00'),
(78, 24, 130, 1, '13.00', 6, NULL, '03:34', NULL, 9, 0, 24, '2022-11-07 17:05:58', '0.00'),
(79, 24, 139, 1, '7.00', 6, NULL, '03:37', NULL, 4, 0, 24, '2022-11-07 17:05:58', '0.00'),
(80, 24, 205, 1, '7.00', 6, NULL, '01:39', NULL, 8, 0, 24, '2022-11-07 17:07:13', '0.00'),
(81, 25, 198, 6, '11.00', 6, NULL, '02:06', NULL, 1, 0, 20, '2022-11-07 17:09:44', '0.00'),
(82, 24, 208, 6, '9.50', 6, NULL, '06:54', NULL, 11, 0, 24, '2022-11-07 17:10:17', '0.00'),
(83, 26, 209, 10, '10.00', 6, NULL, '01:30', NULL, 12, 0, 23, '2022-11-07 17:10:40', '0.00'),
(84, 27, 209, 10, '10.00', 6, NULL, '01:18', NULL, 12, 0, 23, '2022-11-07 17:10:41', '0.00'),
(85, 28, 208, 2, '9.50', 6, NULL, '00:28', NULL, 11, 0, 22, '2022-11-07 17:13:41', '0.00'),
(86, 29, 200, 2, '13.00', 6, NULL, '01:17', 'te pica el cuuuuu', 3, 0, 21, '2022-11-07 17:14:42', '0.00'),
(87, 30, 198, 1, '11.00', 6, NULL, '14:35', NULL, 1, 0, 26, '2022-11-07 17:17:26', '0.00'),
(88, 30, 250, 1, '7.00', 6, NULL, '08:21', NULL, 1, 0, 26, '2022-11-07 17:17:26', '0.00'),
(89, 31, 242, 1, '9.00', 6, NULL, '03:36', NULL, 5, 0, 25, '2022-11-07 17:18:41', '0.00'),
(90, 31, 250, 1, '7.00', 6, NULL, '17:51', NULL, 1, 0, 25, '2022-11-07 17:34:34', '0.00'),
(91, 32, 238, 1, '15.00', 6, NULL, '07:06', NULL, 2, 0, 28, '2022-11-07 17:36:38', '0.00'),
(92, 32, 215, 2, '8.00', 6, NULL, '15:33', 'uno sancochado y el otro frito', 18, 0, 28, '2022-11-07 17:36:38', '0.00'),
(93, 32, 137, 1, '6.00', 6, NULL, '01:55', 'no tan helada ', 2, 0, 28, '2022-11-07 17:36:38', '0.00'),
(94, 32, 144, 1, '9.00', 6, NULL, '04:03', NULL, 9, 0, 28, '2022-11-07 17:36:38', '0.00'),
(95, 33, 199, 2, '11.00', 6, NULL, '12:01', NULL, 2, 0, 27, '2022-11-07 17:40:25', '0.00'),
(96, 33, 250, 2, '7.00', 6, NULL, '11:53', NULL, 1, 0, 27, '2022-11-07 17:40:25', '0.00'),
(97, 34, 144, 1, '9.00', 6, NULL, '02:43', NULL, 9, 0, 29, '2022-11-07 17:41:24', '0.00'),
(98, 35, 237, 1, '6.00', 6, NULL, '08:19', NULL, 1, 0, 32, '2022-11-07 17:47:24', '0.00'),
(99, 35, 209, 1, '10.00', 6, NULL, '12:51', NULL, 12, 0, 32, '2022-11-07 17:47:24', '0.00'),
(100, 35, 214, 1, '15.00', 6, NULL, '12:05', NULL, 17, 0, 32, '2022-11-07 17:47:24', '0.00'),
(101, 35, 227, 1, '21.00', 6, NULL, '14:11', NULL, 30, 0, 32, '2022-11-07 17:47:24', '0.00'),
(102, 35, 94, 1, '6.00', 6, NULL, '01:09', NULL, 4, 0, 32, '2022-11-07 17:47:24', '0.00'),
(103, 35, 118, 1, '10.00', 6, NULL, '03:08', NULL, 28, 0, 32, '2022-11-07 17:47:24', '0.00'),
(104, 35, 261, 1, '3.00', 6, NULL, '07:47', NULL, 2, 0, 32, '2022-11-07 17:51:50', '0.00'),
(105, 36, 221, 1, '9.50', 6, NULL, '25:12', NULL, 24, 0, 34, '2022-11-07 17:58:13', '0.00'),
(106, 36, 228, 2, '30.00', 6, NULL, '25:06', NULL, 31, 0, 34, '2022-11-07 17:58:13', '0.00'),
(107, 36, 250, 2, '7.00', 6, NULL, '25:07', '', 1, 0, 34, '2022-11-07 17:58:13', '0.00'),
(108, 36, 95, 1, '7.50', 6, NULL, '02:11', NULL, 5, 0, 34, '2022-11-07 17:58:13', '0.00'),
(109, 32, 136, 1, '3.00', 6, NULL, '24:59', NULL, 1, 0, 28, '2022-11-07 17:59:24', '0.00'),
(110, 37, 198, 1, '11.00', 6, NULL, '27:57', NULL, 1, 0, 30, '2022-11-07 18:00:39', '0.00'),
(111, 37, 209, 1, '10.00', 6, NULL, '27:59', NULL, 12, 0, 30, '2022-11-07 18:00:39', '0.00'),
(112, 37, 95, 1, '7.50', 6, NULL, '03:48', NULL, 5, 0, 30, '2022-11-07 18:00:39', '0.00'),
(113, 37, 99, 1, '9.50', 6, NULL, '05:39', NULL, 9, 0, 30, '2022-11-07 18:00:39', '0.00'),
(114, 38, 245, 1, '17.00', 6, NULL, '18:55', NULL, 3, 0, 33, '2022-11-07 18:03:36', '0.00'),
(115, 38, 99, 2, '9.50', 6, NULL, '13:51', NULL, 9, 0, 33, '2022-11-07 18:03:36', '0.00'),
(116, 38, 121, 1, '9.00', 6, NULL, '19:09', NULL, 31, 0, 33, '2022-11-07 18:03:36', '0.00'),
(117, 38, 139, 2, '7.00', 6, NULL, '06:34', NULL, 4, 0, 33, '2022-11-07 18:03:36', '0.00'),
(118, 33, 199, 1, '11.00', 6, NULL, '43:14', 'para llevar', 2, 0, 27, '2022-11-07 18:05:52', '0.00'),
(119, 39, 238, 1, '15.00', 6, NULL, '13:50', NULL, 2, 0, 31, '2022-11-07 18:08:52', '0.00'),
(120, 39, 129, 2, '13.00', 6, NULL, '08:19', 'solo uno con chantilly', 8, 0, 31, '2022-11-07 18:08:52', '0.00'),
(121, 40, 254, 1, '5.00', 6, NULL, '05:02', NULL, 10, 0, 35, '2022-11-07 18:27:48', '0.00'),
(122, 40, 209, 1, '10.00', 6, NULL, '05:06', NULL, 12, 0, 35, '2022-11-07 18:27:48', '0.00'),
(123, 40, 99, 1, '9.50', 6, NULL, '03:39', NULL, 9, 0, 35, '2022-11-07 18:27:48', '0.00'),
(124, 40, 262, 1, '3.00', 6, NULL, '04:56', NULL, 3, 0, 35, '2022-11-07 18:27:48', '0.00'),
(125, 30, 95, 1, '7.50', 6, NULL, '17:31', NULL, 5, 0, 46, '2022-11-07 18:34:36', '0.00'),
(126, 41, 242, 1, '9.00', 6, NULL, '06:09', NULL, 5, 0, 38, '2022-11-07 18:35:39', '0.00'),
(127, 41, 222, 1, '9.50', 6, NULL, '06:04', NULL, 25, 0, 38, '2022-11-07 18:35:39', '0.00'),
(128, 41, 147, 1, '3.00', 6, NULL, '00:49', NULL, 2, 0, 38, '2022-11-07 18:35:39', '0.00'),
(129, 41, 261, 1, '3.00', 6, NULL, '00:46', NULL, 2, 0, 38, '2022-11-07 18:35:39', '0.00'),
(130, 36, 207, 3, '9.00', 6, NULL, '53:33', NULL, 10, 0, 34, '2022-11-07 18:38:56', '0.00'),
(131, 40, 254, 1, '5.00', 6, NULL, '24:21', NULL, 10, 0, 35, '2022-11-07 18:40:27', '0.00'),
(132, 42, 209, 2, '10.00', 6, NULL, '07:10', NULL, 12, 0, 43, '2022-11-07 18:40:32', '0.00'),
(133, 42, 139, 2, '7.00', 6, NULL, '05:53', NULL, 4, 0, 43, '2022-11-07 18:40:32', '0.00'),
(134, 36, 250, 1, '7.00', 6, NULL, '53:32', NULL, 1, 0, 34, '2022-11-07 18:44:14', '0.00'),
(135, 30, 209, 2, '10.00', 6, NULL, '38:51', NULL, 12, 0, 46, '2022-11-07 18:45:18', '0.00'),
(136, 30, 95, 1, '7.50', 6, NULL, '34:46', NULL, 5, 0, 46, '2022-11-07 18:45:18', '0.00'),
(137, 43, 254, 1, '5.00', 6, NULL, '03:12', NULL, 10, 0, 37, '2022-11-07 18:46:22', '0.00'),
(138, 43, 238, 1, '15.00', 6, NULL, '09:51', NULL, 2, 0, 37, '2022-11-07 18:46:22', '0.00'),
(139, 43, 122, 1, '12.00', 6, NULL, '05:27', 'CONCHANTILLY\n', 1, 0, 37, '2022-11-07 18:46:22', '0.00'),
(140, 43, 127, 1, '11.50', 6, NULL, '05:39', 'CON CHANTIULLLY\n', 6, 0, 37, '2022-11-07 18:46:22', '0.00'),
(141, 44, 137, 1, '6.00', 6, NULL, '01:58', NULL, 2, 0, 41, '2022-11-07 18:54:48', '0.00'),
(142, 44, 139, 1, '7.00', 6, NULL, '01:57', NULL, 4, 0, 41, '2022-11-07 18:54:48', '0.00'),
(143, 45, 228, 2, '30.00', 6, NULL, '09:15', NULL, 31, 0, 36, '2022-11-07 18:57:48', '0.00'),
(144, 45, 139, 3, '7.00', 6, NULL, '05:28', NULL, 4, 0, 36, '2022-11-07 18:57:48', '0.00'),
(145, 45, 262, 1, '3.00', 6, NULL, '05:39', NULL, 3, 0, 36, '2022-11-07 18:57:48', '0.00'),
(146, 44, 198, 1, '11.00', 6, NULL, '23:53', NULL, 1, 0, 41, '2022-11-07 19:03:17', '0.00'),
(147, 44, 199, 3, '11.00', 6, NULL, '23:55', NULL, 2, 0, 41, '2022-11-07 19:03:17', '0.00'),
(148, 44, 250, 1, '7.00', 6, NULL, '23:56', NULL, 1, 0, 41, '2022-11-07 19:03:17', '0.00'),
(149, 44, 127, 1, '11.50', 6, NULL, '08:51', 'con chantilly', 6, 0, 41, '2022-11-07 19:03:17', '0.00'),
(150, 36, 258, 1, '1.00', 6, NULL, '05:45', NULL, 2, 0, 34, '2022-11-07 19:03:31', '0.00'),
(151, 45, 262, 1, '3.00', 6, NULL, '13:50', NULL, 3, 0, 36, '2022-11-07 19:10:29', '0.00'),
(152, 46, 242, 2, '9.00', 6, NULL, '06:17', NULL, 5, 0, 39, '2022-11-07 19:22:03', '0.00'),
(153, 46, 255, 2, '1.50', 6, NULL, '06:19', NULL, 1, 0, 40, '2022-11-07 19:22:03', '0.00'),
(154, 47, 199, 1, '11.00', 6, NULL, '10:44', NULL, 2, 0, 44, '2022-11-07 19:34:15', '0.00'),
(155, 47, 139, 1, '7.50', 6, NULL, '02:51', NULL, 4, 0, 44, '2022-11-07 19:34:15', '0.00'),
(156, 32, 198, 4, '11.00', 6, NULL, '10:25', NULL, 1, 0, 42, '2022-11-07 19:46:10', '0.00'),
(157, 30, 95, 1, '7.50', 6, NULL, '30:46', NULL, 5, 0, 46, '2022-11-07 19:48:03', '0.00'),
(158, 27, 225, 2, '18.00', 6, NULL, '48:50', NULL, 28, 0, 49, '2022-11-07 19:51:46', '0.00'),
(159, 27, 99, 2, '9.50', 6, NULL, '45:36', NULL, 9, 0, 49, '2022-11-07 19:51:46', '0.00'),
(160, 48, 228, 2, '30.00', 6, NULL, '13:02', NULL, 31, 0, 48, '2022-11-07 20:00:15', '0.00'),
(161, 48, 95, 1, '7.50', 6, NULL, '01:36', NULL, 5, 0, 48, '2022-11-07 20:00:15', '0.00'),
(162, 48, 116, 1, '8.50', 6, NULL, '16:10', NULL, 26, 0, 48, '2022-11-07 20:14:06', '0.00'),
(163, 49, 201, 1, '16.00', 6, NULL, '15:51', NULL, 4, 0, 50, '2022-11-07 20:14:37', '0.00'),
(164, 49, 250, 1, '7.00', 6, NULL, '10:59', NULL, 1, 0, 50, '2022-11-07 20:14:37', '0.00'),
(165, 49, 136, 1, '3.00', 6, NULL, '01:50', NULL, 1, 0, 50, '2022-11-07 20:14:37', '0.00'),
(166, 50, 242, 1, '9.00', 6, NULL, '06:26', NULL, 5, 0, 45, '2022-11-07 20:19:05', '0.00'),
(167, 51, 221, 1, '9.50', 6, NULL, '10:13', NULL, 24, 0, 51, '2022-11-07 20:20:28', '0.00'),
(168, 51, 222, 1, '9.50', 6, NULL, '16:09', NULL, 25, 0, 51, '2022-11-07 20:20:28', '0.00'),
(169, 51, 95, 1, '7.50', 6, NULL, '04:03', NULL, 5, 0, 51, '2022-11-07 20:20:28', '0.00'),
(170, 51, 260, 1, '3.00', 6, NULL, '04:03', NULL, 1, 0, 51, '2022-11-07 20:20:28', '0.00'),
(171, 52, 198, 1, '11.00', 6, NULL, '10:28', NULL, 1, 0, 47, '2022-11-07 20:28:28', '0.00'),
(172, 52, 199, 1, '11.00', 6, NULL, '10:26', NULL, 2, 0, 47, '2022-11-07 20:28:28', '0.00'),
(173, 52, 215, 1, '8.00', 6, NULL, '09:54', NULL, 18, 0, 47, '2022-11-07 20:28:28', '0.00'),
(174, 52, 132, 1, '14.00', 6, NULL, '06:29', NULL, 11, 0, 47, '2022-11-07 20:28:28', '0.00'),
(175, 52, 140, 1, '7.50', 6, NULL, '03:39', NULL, 5, 0, 47, '2022-11-07 20:28:28', '0.00'),
(176, 52, 140, 1, '7.50', 4, NULL, NULL, NULL, 5, 0, NULL, '2022-11-07 20:40:13', '0.00'),
(177, 53, 198, 1, '11.00', 4, NULL, NULL, NULL, 1, 0, NULL, '2022-11-07 20:42:25', '0.00'),
(178, 53, 201, 1, '16.00', 4, NULL, NULL, 'sin helar\n', 4, 0, NULL, '2022-11-07 20:42:25', '0.00'),
(179, 53, 140, 2, '7.50', 6, NULL, '32:32', NULL, 5, 0, 52, '2022-11-07 20:42:25', '0.00'),
(180, 54, 253, 3, '5.00', 4, NULL, NULL, NULL, 9, 1, NULL, '2022-11-07 21:12:32', '0.00'),
(181, 54, 99, 1, '9.50', 6, NULL, '02:21', NULL, 9, 0, 53, '2022-11-07 21:12:32', '0.00'),
(182, 54, 130, 1, '13.00', 6, NULL, '02:24', NULL, 9, 0, 53, '2022-11-07 21:12:32', '0.00'),
(183, 55, 253, 1, '5.00', 4, NULL, NULL, NULL, 9, 1, NULL, '2022-11-07 21:16:44', '0.00'),
(184, 55, 201, 1, '16.00', 4, NULL, NULL, NULL, 4, 1, NULL, '2022-11-07 21:16:44', '0.00'),
(185, 55, 209, 2, '10.00', 4, NULL, NULL, NULL, 12, 1, NULL, '2022-11-07 21:16:44', '0.00'),
(186, 55, 250, 1, '7.00', 4, NULL, NULL, NULL, 1, 1, NULL, '2022-11-07 21:16:44', '0.00'),
(187, 55, 156, 1, '13.00', 6, NULL, '12:27', NULL, 6, 0, 55, '2022-11-07 21:16:44', '0.00'),
(188, 55, 163, 5, '13.00', 6, NULL, '12:28', NULL, 13, 0, 55, '2022-11-07 21:16:44', '0.00'),
(189, 56, 122, 1, '12.00', 6, NULL, '10:51', NULL, 1, 0, 57, '2022-11-07 21:18:26', '0.00'),
(190, 56, 123, 3, '13.00', 6, NULL, '10:53', NULL, 2, 0, 57, '2022-11-07 21:18:26', '0.00'),
(191, 57, 126, 1, '13.00', 6, NULL, '00:59', 'sin chantilly\n', 5, 0, 58, '2022-11-07 21:28:24', '0.00'),
(192, 57, 139, 2, '7.50', 6, NULL, '01:00', NULL, 4, 0, 58, '2022-11-07 21:28:24', '0.00'),
(193, 58, 99, 1, '9.50', 6, NULL, '00:58', NULL, 9, 0, 54, '2022-11-07 21:28:32', '0.00'),
(194, 58, 118, 1, '10.00', 6, NULL, '01:00', NULL, 28, 0, 54, '2022-11-07 21:28:32', '0.00'),
(195, 58, 249, 1, '7.00', 6, NULL, '01:03', NULL, 4, 0, 54, '2022-11-07 21:28:32', '0.00'),
(196, 58, 262, 1, '3.00', 6, NULL, '01:05', NULL, 3, 0, 54, '2022-11-07 21:28:32', '0.00'),
(197, 59, 213, 1, '13.00', 4, NULL, NULL, NULL, 16, 1, NULL, '2022-11-07 21:30:04', '0.00'),
(198, 59, 214, 1, '15.00', 4, NULL, NULL, NULL, 17, 1, NULL, '2022-11-07 21:30:04', '0.00'),
(199, 59, 118, 1, '10.00', 6, NULL, '59:11', NULL, 28, 0, 60, '2022-11-07 21:30:04', '0.00'),
(200, 59, 132, 1, '14.00', 6, NULL, '59:39', NULL, 11, 0, 60, '2022-11-07 21:30:04', '0.00'),
(201, 27, 122, 1, '12.00', 6, NULL, '18:24', NULL, 1, 0, 59, '2022-11-07 21:31:26', '0.00'),
(202, 27, 260, 1, '3.00', 6, NULL, '18:25', NULL, 1, 0, 59, '2022-11-07 21:31:26', '0.00'),
(203, 60, 245, 1, '17.00', 4, NULL, NULL, NULL, 3, 1, NULL, '2022-11-07 21:32:15', '0.00'),
(204, 60, 123, 2, '13.00', 6, NULL, '56:46', NULL, 2, 0, 56, '2022-11-07 21:32:15', '0.00'),
(205, 61, 208, 1, '9.50', 6, NULL, '00:17', NULL, 11, 0, 61, '2022-11-08 17:51:07', '0.00'),
(206, 61, 228, 1, '30.00', 6, NULL, '00:14', NULL, 31, 0, 61, '2022-11-08 17:51:07', '0.00'),
(207, 61, 250, 1, '7.00', 6, NULL, '00:12', NULL, 1, 0, 61, '2022-11-08 17:51:07', '0.00'),
(208, 61, 99, 2, '9.50', 6, NULL, '00:29', NULL, 9, 0, 61, '2022-11-08 17:51:07', '0.00'),
(209, 62, 139, 1, '7.50', 6, NULL, '02:49', NULL, 4, 0, 62, '2022-11-08 17:54:11', '0.00'),
(210, 63, 253, 1, '5.00', 6, NULL, '06:13', NULL, 9, 0, 66, '2022-11-08 18:18:53', '0.00'),
(211, 63, 209, 1, '10.00', 6, NULL, '09:16', NULL, 12, 0, 66, '2022-11-08 18:18:53', '0.00'),
(212, 63, 141, 1, '7.50', 6, NULL, '04:02', NULL, 6, 0, 66, '2022-11-08 18:18:53', '0.00'),
(213, 63, 261, 1, '3.00', 6, NULL, '04:06', NULL, 2, 0, 66, '2022-11-08 18:18:53', '0.00'),
(214, 64, 209, 3, '10.00', 6, NULL, '06:14', NULL, 12, 0, 63, '2022-11-08 18:24:49', '0.00'),
(215, 64, 99, 2, '9.50', 6, NULL, '09:21', NULL, 9, 0, 63, '2022-11-08 18:24:49', '0.00'),
(216, 64, 102, 1, '7.50', 6, NULL, '09:25', NULL, 12, 0, 63, '2022-11-08 18:24:49', '0.00'),
(217, 63, 253, 2, '5.00', 6, NULL, '18:50', NULL, 9, 0, 66, '2022-11-08 18:30:16', '0.00'),
(218, 63, 141, 2, '7.50', 6, NULL, '32:08', NULL, 6, 0, 66, '2022-11-08 18:30:16', '0.00'),
(219, 65, 200, 1, '13.00', 6, NULL, '17:41', NULL, 3, 0, 65, '2022-11-08 18:33:43', '0.00'),
(220, 65, 207, 1, '9.00', 6, NULL, '17:35', NULL, 10, 0, 65, '2022-11-08 18:33:43', '0.00'),
(221, 65, 209, 1, '10.00', 6, NULL, '17:38', NULL, 12, 0, 65, '2022-11-08 18:33:43', '0.00'),
(222, 65, 103, 1, '12.00', 6, NULL, '11:28', 'con leche deslactosada', 13, 0, 65, '2022-11-08 18:33:43', '0.00'),
(223, 66, 200, 1, '13.00', 6, NULL, '17:07', NULL, 3, 0, 65, '2022-11-08 18:33:43', '0.00'),
(224, 66, 207, 1, '9.00', 6, NULL, '11:02', NULL, 10, 0, 65, '2022-11-08 18:33:43', '0.00'),
(225, 66, 209, 1, '10.00', 6, NULL, '11:04', NULL, 12, 0, 65, '2022-11-08 18:33:43', '0.00'),
(226, 66, 103, 3, '12.00', 6, NULL, '09:44', NULL, 13, 0, 65, '2022-11-08 18:33:43', '0.00'),
(227, 67, 198, 1, '11.00', 6, NULL, '15:34', NULL, 1, 0, 64, '2022-11-08 18:36:09', '0.00'),
(228, 67, 99, 1, '9.50', 6, NULL, '02:07', NULL, 9, 0, 64, '2022-11-08 18:36:09', '0.00'),
(229, 67, 260, 2, '3.00', 6, NULL, '11:00', NULL, 1, 0, 64, '2022-11-08 18:36:09', '0.00'),
(230, 68, 198, 2, '11.00', 6, NULL, '17:29', NULL, 1, 0, 68, '2022-11-08 18:39:52', '0.00'),
(231, 68, 99, 2, '9.50', 6, NULL, '12:49', NULL, 9, 0, 68, '2022-11-08 18:39:52', '0.00'),
(232, 69, 199, 2, '11.00', 6, NULL, '17:20', NULL, 2, 0, 72, '2022-11-08 18:43:24', '0.00'),
(233, 69, 99, 2, '9.50', 6, NULL, '07:43', NULL, 9, 0, 72, '2022-11-08 18:43:24', '0.00'),
(234, 69, 118, 1, '10.00', 6, NULL, '08:46', NULL, 28, 0, 72, '2022-11-08 18:43:24', '0.00'),
(235, 66, 209, 1, '10.00', 6, NULL, '16:57', NULL, 12, 0, 65, '2022-11-08 18:50:09', '0.00'),
(236, 66, 141, 1, '7.50', 6, NULL, '20:30', 'solo piña', 6, 0, 65, '2022-11-08 18:50:09', '0.00'),
(237, 67, 260, 1, '3.00', 6, NULL, '24:21', NULL, 1, 0, 64, '2022-11-08 18:57:03', '0.00'),
(238, 70, 144, 1, '9.00', 6, NULL, '06:55', NULL, 9, 0, 75, '2022-11-08 19:10:02', '0.00'),
(239, 33, 207, 1, '9.00', 6, NULL, '38:43', NULL, 10, 0, 71, '2022-11-08 19:13:37', '0.00'),
(240, 33, 209, 1, '10.00', 6, NULL, '38:45', NULL, 12, 0, 71, '2022-11-08 19:13:37', '0.00'),
(241, 33, 140, 1, '7.50', 6, NULL, '40:11', NULL, 5, 0, 71, '2022-11-08 19:13:37', '0.00'),
(242, 33, 141, 1, '7.50', 6, NULL, '40:12', NULL, 6, 0, 71, '2022-11-08 19:13:37', '0.00'),
(243, 70, 209, 1, '10.00', 6, NULL, '07:08', NULL, 12, 0, 75, '2022-11-08 19:16:38', '0.00'),
(244, 70, 123, 1, '13.00', 6, NULL, '06:57', NULL, 2, 0, 75, '2022-11-08 19:16:38', '0.00'),
(245, 71, 99, 1, '9.50', 6, NULL, '02:27', NULL, 9, 0, 70, '2022-11-08 19:20:14', '0.00'),
(246, 72, 209, 3, '10.00', 6, NULL, '03:19', NULL, 12, 0, 67, '2022-11-08 19:21:41', '0.00'),
(247, 73, 237, 2, '6.00', 6, NULL, '12:15', NULL, 1, 0, 73, '2022-11-08 19:23:32', '0.00'),
(248, 73, 206, 1, '7.50', 6, NULL, '12:21', NULL, 9, 0, 73, '2022-11-08 19:23:32', '0.00'),
(249, 73, 208, 1, '9.50', 6, NULL, '13:11', NULL, 11, 0, 73, '2022-11-08 19:23:32', '0.00'),
(250, 73, 221, 1, '9.50', 6, NULL, '13:08', NULL, 24, 0, 73, '2022-11-08 19:23:32', '0.00'),
(251, 73, 122, 2, '12.00', 6, NULL, '08:05', NULL, 1, 0, 73, '2022-11-08 19:23:32', '0.00'),
(252, 73, 141, 1, '7.50', 6, NULL, '08:08', NULL, 6, 0, 73, '2022-11-08 19:23:32', '0.00'),
(253, 74, 209, 2, '10.00', 6, NULL, '11:18', NULL, 12, 0, 74, '2022-11-08 19:24:21', '0.00'),
(254, 74, 125, 1, '18.00', 6, NULL, '07:49', NULL, 4, 0, 74, '2022-11-08 19:24:21', '0.00'),
(255, 74, 141, 1, '7.50', 6, NULL, '07:49', NULL, 6, 0, 74, '2022-11-08 19:24:21', '0.00'),
(256, 27, 228, 2, '30.00', 6, NULL, '31:03', NULL, 31, 0, 69, '2022-11-08 19:26:47', '0.00'),
(257, 27, 139, 2, '7.50', 6, NULL, '28:45', NULL, 4, 0, 69, '2022-11-08 19:26:47', '0.00'),
(258, 71, 99, 2, '9.50', 6, NULL, '19:08', NULL, 9, 0, 70, '2022-11-08 19:35:11', '0.00'),
(259, 73, 141, 1, '7.50', 6, NULL, '18:30', NULL, 6, 0, 73, '2022-11-08 19:36:08', '0.00'),
(260, 73, 237, 1, '6.00', 6, NULL, '19:22', NULL, 1, 0, 73, '2022-11-08 19:37:36', '0.00'),
(261, 75, 165, 2, '15.00', 6, NULL, '06:01', NULL, 15, 0, 80, '2022-11-08 19:43:18', '0.00'),
(262, 74, 245, 1, '17.00', 6, NULL, '32:08', NULL, 3, 0, 74, '2022-11-08 19:46:09', '0.00'),
(263, 73, 204, 1, '5.00', 6, NULL, '25:46', NULL, 7, 0, 73, '2022-11-08 19:46:21', '0.00'),
(264, 73, 147, 2, '3.00', 6, NULL, '26:21', NULL, 2, 0, 73, '2022-11-08 19:46:21', '0.00'),
(265, 76, 226, 3, '20.50', 6, NULL, '20:39', NULL, 29, 0, 78, '2022-11-08 19:50:44', '0.00'),
(266, 76, 137, 1, '6.00', 6, NULL, '03:23', '', 2, 0, 78, '2022-11-08 19:50:44', '0.00'),
(267, 76, 141, 3, '7.50', 6, NULL, '03:20', NULL, 6, 0, 78, '2022-11-08 19:52:24', '0.00'),
(268, 75, 198, 1, '11.00', 6, NULL, '30:06', NULL, 1, 0, 80, '2022-11-08 20:00:15', '0.00'),
(269, 75, 165, 2, '15.00', 6, NULL, '21:57', NULL, 15, 0, 80, '2022-11-08 20:00:15', '0.00'),
(270, 77, 136, 1, '3.00', 6, NULL, '01:55', 'super helada', 1, 0, 85, '2022-11-08 20:06:20', '0.00'),
(271, 77, 207, 1, '9.00', 6, NULL, '17:03', NULL, 10, 0, 85, '2022-11-08 20:13:09', '0.00'),
(272, 77, 209, 1, '10.00', 6, NULL, '17:04', NULL, 12, 0, 85, '2022-11-08 20:13:09', '0.00'),
(273, 77, 250, 1, '7.00', 6, NULL, '15:35', NULL, 1, 0, 85, '2022-11-08 20:13:09', '0.00'),
(274, 77, 146, 1, '3.00', 6, NULL, '10:54', 'helada', 1, 0, 85, '2022-11-08 20:13:09', '0.00'),
(275, 77, 260, 1, '3.00', 6, NULL, '10:56', NULL, 1, 0, 85, '2022-11-08 20:13:09', '0.00'),
(276, 78, 199, 1, '11.00', 6, NULL, '07:50', NULL, 2, 0, 77, '2022-11-08 20:13:17', '0.00'),
(277, 78, 140, 1, '7.50', 6, NULL, '04:03', NULL, 5, 0, 77, '2022-11-08 20:13:17', '0.00'),
(278, 78, 261, 1, '3.00', 6, NULL, '04:05', NULL, 2, 0, 77, '2022-11-08 20:13:17', '0.00'),
(279, 66, 254, 2, '5.00', 6, NULL, '03:41', NULL, 10, 0, 79, '2022-11-08 20:23:10', '0.00'),
(280, 66, 209, 1, '10.00', 6, NULL, '08:45', NULL, 12, 0, 79, '2022-11-08 20:23:10', '0.00'),
(281, 66, 210, 2, '11.00', 6, NULL, '11:36', NULL, 13, 0, 79, '2022-11-08 20:23:10', '0.00'),
(282, 66, 213, 1, '13.00', 6, NULL, '08:18', NULL, 16, 0, 79, '2022-11-08 20:23:10', '0.00'),
(283, 66, 228, 2, '30.00', 6, NULL, '11:39', NULL, 31, 0, 79, '2022-11-08 20:23:10', '0.00'),
(284, 66, 103, 1, '12.00', 6, NULL, '04:01', NULL, 13, 0, 79, '2022-11-08 20:23:10', '0.00'),
(285, 66, 195, 1, '6.00', 6, NULL, '04:01', NULL, 35, 0, 79, '2022-11-08 20:23:10', '0.00'),
(286, 66, 124, 1, '16.00', 6, NULL, '04:02', NULL, 3, 0, 79, '2022-11-08 20:23:10', '0.00'),
(287, 66, 127, 1, '11.50', 6, NULL, '04:16', NULL, 6, 0, 79, '2022-11-08 20:23:10', '0.00'),
(288, 66, 135, 1, '17.00', 6, NULL, '04:17', NULL, 14, 0, 79, '2022-11-08 20:23:10', '0.00'),
(289, 66, 261, 2, '3.00', 6, NULL, '06:45', NULL, 2, 0, 79, '2022-11-08 20:23:10', '0.00'),
(290, 79, 204, 2, '5.00', 6, NULL, '06:35', NULL, 7, 0, 76, '2022-11-08 20:26:29', '0.00'),
(291, 79, 250, 3, '7.00', 6, NULL, '06:37', NULL, 1, 0, 76, '2022-11-08 20:26:29', '0.00'),
(292, 79, 118, 1, '10.00', 6, NULL, '11:41', NULL, 28, 0, 76, '2022-11-08 20:26:29', '0.00'),
(293, 78, 209, 1, '10.00', 6, NULL, '28:58', NULL, 12, 0, 77, '2022-11-08 20:26:58', '0.00'),
(294, 75, 209, 1, '10.00', 6, NULL, '58:57', NULL, 12, 0, 80, '2022-11-08 20:35:10', '0.00'),
(295, 75, 165, 2, '15.00', 6, NULL, '57:18', NULL, 15, 0, 80, '2022-11-08 20:35:10', '0.00'),
(296, 80, 207, 2, '9.00', 6, NULL, '16:21', NULL, 10, 0, 83, '2022-11-08 20:35:56', '0.00'),
(297, 80, 134, 2, '14.00', 6, NULL, '08:20', 'sin chantilly', 13, 0, 83, '2022-11-08 20:35:56', '0.00'),
(298, 66, 209, 1, '10.00', 6, NULL, '11:33', NULL, 12, 0, 79, '2022-11-08 20:42:44', '0.00'),
(299, 77, 209, 2, '10.00', 6, NULL, '46:04', NULL, 12, 0, 85, '2022-11-08 20:45:41', '0.00'),
(300, 77, 260, 1, '3.00', 6, NULL, '42:06', NULL, 1, 0, 85, '2022-11-08 20:45:41', '0.00'),
(301, 75, 134, 1, '14.00', 6, NULL, '09:46', NULL, 13, 0, 80, '2022-11-08 20:49:52', '0.00'),
(302, 81, 164, 2, '15.00', 6, NULL, '04:58', NULL, 14, 0, 89, '2022-11-08 20:53:47', '0.00'),
(303, 75, 165, 2, '15.00', 6, NULL, '18:23', NULL, 15, 0, 80, '2022-11-08 20:58:32', '0.00'),
(304, 82, 129, 2, '13.00', 6, NULL, '09:09', 'sin chantilly', 8, 0, 87, '2022-11-08 21:07:07', '0.00'),
(305, 83, 207, 2, '9.00', 6, NULL, '06:04', NULL, 10, 0, 81, '2022-11-08 21:13:10', '0.00'),
(306, 83, 99, 1, '9.50', 6, NULL, '--:--', NULL, 9, 0, 81, '2022-11-08 21:13:10', '0.00'),
(307, 83, 127, 1, '11.50', 6, NULL, '03:12', 'con chantilly', 6, 0, 81, '2022-11-08 21:13:10', '0.00'),
(308, 84, 215, 1, '8.00', 6, NULL, '13:22', NULL, 18, 0, 82, '2022-11-08 21:17:13', '0.00'),
(309, 84, 224, 1, '15.00', 6, NULL, '13:19', NULL, 27, 0, 82, '2022-11-08 21:17:13', '0.00'),
(310, 84, 137, 1, '6.00', 6, NULL, '08:52', NULL, 2, 0, 82, '2022-11-08 21:17:13', '0.00'),
(311, 84, 139, 1, '7.50', 6, NULL, '10:02', NULL, 4, 0, 82, '2022-11-08 21:17:13', '0.00'),
(312, 75, 165, 1, '15.00', 6, NULL, '42:42', '', 15, 0, 80, '2022-11-08 21:19:10', '0.00'),
(313, 75, 165, 1, '15.00', 6, NULL, '43:48', '', 15, 0, 80, '2022-11-08 21:19:13', '0.00'),
(314, 82, 198, 1, '11.00', 6, NULL, '35:50', NULL, 1, 0, 87, '2022-11-08 21:26:41', '0.00'),
(315, 82, 129, 1, '13.00', 6, NULL, '27:23', NULL, 8, 0, 87, '2022-11-08 21:26:41', '0.00'),
(316, 82, 162, 1, '13.00', 6, NULL, '27:29', NULL, 12, 0, 87, '2022-11-08 21:30:38', '0.00'),
(317, 84, 254, 1, '5.00', 6, NULL, '22:35', NULL, 10, 0, 82, '2022-11-08 21:31:57', '0.00'),
(318, 80, 147, 1, '3.00', 6, NULL, '--:--', NULL, 2, 0, 83, '2022-11-08 21:32:21', '0.00'),
(319, 77, 136, 2, '3.00', 6, NULL, '29:13', NULL, 1, 0, 85, '2022-11-08 21:35:23', '0.00'),
(320, 85, 245, 1, '17.00', 6, NULL, '06:58', NULL, 3, 0, 86, '2022-11-08 21:45:13', '0.00'),
(321, 85, 125, 3, '18.00', 6, NULL, '11:15', 'con chantilyy', 4, 0, 86, '2022-11-08 21:45:13', '0.00'),
(322, 86, 178, 1, '8.50', 6, NULL, '01:42', NULL, 16, 0, 88, '2022-11-08 21:45:23', '0.00'),
(323, 82, 198, 1, '11.00', 6, NULL, '55:44', NULL, 1, 0, 87, '2022-11-08 21:53:46', '0.00'),
(324, 82, 162, 1, '13.00', 6, NULL, '02:58', NULL, 12, 0, 87, '2022-11-08 22:04:12', '0.00'),
(325, 82, 129, 1, '13.00', 6, NULL, '03:01', NULL, 8, 0, 87, '2022-11-08 22:04:12', '0.00'),
(326, 81, 164, 2, '15.00', 6, NULL, '21:59', NULL, 14, 0, 89, '2022-11-08 22:10:42', '0.00'),
(327, 87, 148, 1, '5.00', 6, NULL, '00:23', '', 3, 0, 84, '2022-11-08 22:23:17', '0.00'),
(328, 88, 208, 1, '9.50', 6, NULL, '09:09', NULL, 11, 0, 91, '2022-11-09 17:12:24', '0.00'),
(329, 88, 144, 1, '9.00', 6, NULL, '30:25', 'sin helar xfavor', 9, 0, 91, '2022-11-09 17:12:24', '0.00'),
(330, 88, 95, 1, '7.50', 6, NULL, '30:25', NULL, 5, 0, 91, '2022-11-09 17:21:48', '0.00'),
(331, 88, 249, 1, '7.00', 6, NULL, '30:34', NULL, 4, 0, 91, '2022-11-09 17:21:48', '0.00'),
(332, 88, 163, 1, '13.00', 6, NULL, '30:28', NULL, 13, 0, 91, '2022-11-09 17:21:48', '0.00'),
(333, 88, 249, 1, '7.00', 6, NULL, '30:27', NULL, 4, 0, 91, '2022-11-09 17:26:53', '0.00'),
(334, 88, 147, 1, '3.00', 6, NULL, '30:29', NULL, 2, 0, 91, '2022-11-09 17:26:53', '0.00'),
(335, 88, 133, 1, '14.00', 6, NULL, '30:32', NULL, 12, 0, 91, '2022-11-09 17:26:53', '0.00'),
(336, 89, 209, 2, '10.00', 6, NULL, '16:21', NULL, 12, 0, 90, '2022-11-09 18:51:30', '0.00'),
(337, 89, 226, 2, '20.50', 6, NULL, '16:15', NULL, 29, 0, 90, '2022-11-09 18:51:30', '0.00'),
(338, 89, 99, 3, '9.50', 6, NULL, '38:34', NULL, 9, 0, 90, '2022-11-09 18:51:30', '0.00'),
(339, 89, 123, 1, '13.00', 6, NULL, '38:22', NULL, 2, 0, 90, '2022-11-09 18:51:30', '0.00'),
(340, 89, 141, 1, '7.50', 6, NULL, '38:24', NULL, 6, 0, 90, '2022-11-09 18:51:30', '0.00'),
(341, 89, 249, 1, '7.00', 6, NULL, '38:26', NULL, 4, 0, 90, '2022-11-09 19:01:14', '0.00'),
(342, 89, 141, 1, '7.50', 6, NULL, '38:30', NULL, 6, 0, 90, '2022-11-09 19:20:42', '0.00'),
(343, 89, 141, 1, '7.50', 6, NULL, '40:58', NULL, 6, 0, 90, '2022-11-09 19:31:18', '0.00'),
(344, 90, 99, 2, '9.50', 6, NULL, '00:46', NULL, 9, 0, 92, '2022-11-09 19:36:01', '0.00'),
(345, 91, 209, 2, '10.00', 6, NULL, '06:16', NULL, 12, 0, 95, '2022-11-09 19:46:36', '0.00'),
(346, 91, 99, 1, '9.50', 6, NULL, '04:01', NULL, 9, 0, 95, '2022-11-09 19:46:36', '0.00'),
(347, 91, 138, 1, '6.50', 6, NULL, '04:04', NULL, 3, 0, 95, '2022-11-09 19:46:36', '0.00'),
(348, 92, 205, 1, '7.00', 6, NULL, '05:32', NULL, 8, 0, 94, '2022-11-09 19:48:10', '0.00'),
(349, 92, 209, 2, '10.00', 6, NULL, '05:34', NULL, 12, 0, 94, '2022-11-09 19:48:10', '0.00'),
(350, 92, 99, 3, '9.50', 6, NULL, '04:27', NULL, 9, 0, 94, '2022-11-09 19:48:10', '0.00'),
(351, 93, 199, 1, '11.00', 6, NULL, '10:19', NULL, 2, 0, 106, '2022-11-09 19:49:21', '0.00'),
(352, 92, 245, 1, '17.00', 6, NULL, '11:34', NULL, 3, 0, 94, '2022-11-09 19:52:52', '0.00'),
(353, 94, 99, 1, '9.50', 6, NULL, '10:07', '', 9, 0, 107, '2022-11-09 19:53:56', '0.00'),
(354, 94, 249, 1, '7.00', 6, NULL, '10:07', NULL, 4, 0, 107, '2022-11-09 19:53:56', '0.00'),
(355, 95, 127, 1, '11.50', 6, NULL, '08:51', 'con chantillyt\n', 6, 0, 105, '2022-11-09 20:01:21', '0.00'),
(356, 96, 228, 2, '30.00', 6, NULL, '21:15', NULL, 31, 0, 96, '2022-11-09 20:01:24', '0.00'),
(357, 96, 139, 2, '7.50', 6, NULL, '09:30', NULL, 4, 0, 96, '2022-11-09 20:01:24', '0.00'),
(358, 97, 226, 1, '20.50', 6, NULL, '17:18', NULL, 29, 0, 93, '2022-11-09 20:05:29', '0.00'),
(359, 97, 228, 2, '30.00', 6, NULL, '17:25', NULL, 31, 0, 93, '2022-11-09 20:05:29', '0.00'),
(360, 97, 132, 1, '14.00', 6, NULL, '05:29', 'con chantilly', 11, 0, 93, '2022-11-09 20:05:29', '0.00'),
(361, 97, 137, 2, '6.00', 6, NULL, '05:27', 'frsca no tan helada', 2, 0, 93, '2022-11-09 20:05:29', '0.00'),
(362, 97, 253, 4, '5.00', 6, NULL, '23:23', NULL, 9, 0, 93, '2022-11-09 20:14:22', '0.00'),
(363, 91, 164, 2, '15.00', 6, NULL, '31:55', NULL, 14, 0, 95, '2022-11-09 20:18:21', '0.00'),
(364, 96, 209, 1, '10.00', 6, NULL, '31:39', NULL, 12, 0, 96, '2022-11-09 20:26:22', '0.00'),
(365, 96, 144, 1, '9.00', 6, NULL, '27:53', NULL, 9, 0, 96, '2022-11-09 20:26:22', '0.00'),
(366, 98, 141, 1, '7.50', 6, NULL, '13:25', NULL, 6, 0, 97, '2022-11-09 20:45:49', '0.00'),
(367, 98, 144, 1, '9.00', 6, NULL, '13:30', NULL, 9, 0, 97, '2022-11-09 20:45:49', '0.00'),
(368, 99, 228, 3, '30.00', 6, NULL, '23:27', NULL, 31, 0, 102, '2022-11-09 21:06:45', '0.00'),
(369, 99, 127, 1, '11.50', 6, NULL, '04:08', NULL, 6, 0, 102, '2022-11-09 21:06:45', '0.00'),
(370, 100, 198, 1, '11.00', 6, NULL, '19:06', NULL, 1, 0, 99, '2022-11-09 21:14:19', '0.00'),
(371, 100, 122, 1, '12.00', 6, NULL, '03:50', NULL, 1, 0, 99, '2022-11-09 21:14:19', '0.00'),
(372, 100, 129, 1, '13.00', 6, NULL, '01:12', NULL, 8, 0, 99, '2022-11-09 21:14:19', '0.00'),
(373, 99, 139, 2, '7.50', 6, NULL, '12:41', NULL, 4, 0, 102, '2022-11-09 21:17:14', '0.00'),
(374, 101, 228, 2, '30.00', 6, NULL, '13:40', NULL, 31, 0, 101, '2022-11-09 21:17:54', '0.00'),
(375, 101, 95, 1, '7.50', 6, NULL, '00:58', NULL, 5, 0, 101, '2022-11-09 21:17:54', '0.00'),
(376, 101, 144, 1, '9.00', 6, NULL, '01:05', NULL, 9, 0, 101, '2022-11-09 21:17:54', '0.00'),
(377, 66, 210, 1, '11.00', 6, NULL, '58:34', NULL, 13, 0, 104, '2022-11-09 21:21:58', '0.00'),
(378, 66, 125, 2, '18.00', 6, NULL, '48:51', NULL, 4, 0, 104, '2022-11-09 21:21:58', '0.00'),
(379, 102, 129, 1, '13.00', 6, NULL, '00:45', NULL, 8, 0, 98, '2022-11-09 21:22:29', '0.00'),
(380, 103, 198, 2, '11.00', 6, NULL, '16:34', NULL, 1, 0, 103, '2022-11-09 21:25:34', '0.00'),
(381, 103, 156, 2, '13.00', 6, NULL, '00:10', NULL, 6, 0, 103, '2022-11-09 21:25:34', '0.00'),
(382, 99, 236, 1, '7.00', 6, NULL, '35:26', NULL, 8, 0, 102, '2022-11-09 21:35:39', '0.00'),
(383, 99, 139, 1, '7.50', 6, NULL, '32:14', NULL, 4, 0, 102, '2022-11-09 21:38:32', '0.00'),
(384, 104, 201, 2, '16.00', 6, NULL, '16:50', NULL, 4, 0, 108, '2022-11-09 21:39:33', '0.00'),
(385, 104, 141, 2, '7.50', 6, NULL, '00:49', NULL, 6, 0, 108, '2022-11-09 21:39:33', '0.00'),
(386, 99, 228, 1, '30.00', 6, NULL, '49:35', NULL, 31, 0, 102, '2022-11-09 21:45:18', '0.00'),
(387, 27, 209, 1, '10.00', 6, NULL, '49:38', NULL, 12, 0, 100, '2022-11-09 21:51:40', '0.00'),
(388, 27, 118, 1, '10.00', 6, NULL, '43:27', NULL, 28, 0, 100, '2022-11-09 21:51:40', '0.00'),
(389, 27, 127, 1, '11.50', 6, NULL, '43:26', NULL, 6, 0, 100, '2022-11-09 21:51:40', '0.00'),
(390, 103, 199, 2, '11.00', 6, NULL, '48:11', NULL, 2, 0, 103, '2022-11-09 21:59:53', '0.00'),
(391, 99, 228, 1, '30.00', 6, NULL, '26:09', NULL, 31, 0, 102, '2022-11-09 22:05:04', '0.00'),
(392, 103, 156, 2, '13.00', 6, NULL, '42:02', NULL, 6, 0, 103, '2022-11-09 22:07:14', '0.00'),
(393, 93, 150, 1, '5.00', 6, NULL, '59:25', NULL, 5, 0, 106, '2022-11-09 22:45:41', '0.00'),
(394, 105, 129, 1, '13.00', 6, NULL, '00:10', NULL, 8, 0, 109, '2022-11-10 17:24:33', '0.00'),
(395, 106, 245, 1, '17.00', 6, NULL, '06:25', NULL, 3, 0, 113, '2022-11-10 17:44:37', '0.00'),
(396, 106, 99, 1, '9.50', 6, NULL, '03:00', NULL, 9, 0, 113, '2022-11-10 17:44:37', '0.00'),
(397, 106, 132, 1, '14.00', 6, NULL, '03:08', NULL, 11, 0, 113, '2022-11-10 17:44:37', '0.00'),
(398, 107, 238, 1, '15.00', 6, NULL, '19:32', NULL, 2, 0, 110, '2022-11-10 18:01:06', '0.00'),
(399, 107, 207, 1, '9.00', 6, NULL, '19:24', NULL, 10, 0, 110, '2022-11-10 18:01:06', '0.00'),
(400, 107, 99, 1, '9.50', 6, NULL, '03:05', NULL, 9, 0, 110, '2022-11-10 18:01:06', '0.00'),
(401, 107, 126, 1, '13.00', 6, NULL, '03:43', NULL, 5, 0, 110, '2022-11-10 18:01:06', '0.00'),
(402, 108, 209, 1, '10.00', 6, NULL, '09:00', NULL, 12, 0, 112, '2022-11-10 18:11:27', '0.00'),
(403, 108, 126, 1, '13.00', 6, NULL, '08:08', NULL, 5, 0, 112, '2022-11-10 18:11:27', '0.00'),
(404, 108, 257, 1, '1.00', 6, NULL, '08:45', NULL, 1, 0, 112, '2022-11-10 18:20:02', '0.00'),
(405, 66, 227, 1, '21.00', 6, NULL, '09:23', NULL, 30, 0, 111, '2022-11-10 18:23:39', '0.00'),
(406, 66, 228, 1, '30.00', 6, NULL, '09:26', NULL, 31, 0, 111, '2022-11-10 18:23:39', '0.00'),
(407, 66, 99, 1, '9.50', 6, NULL, '59:33', NULL, 9, 0, 111, '2022-11-10 18:23:39', '0.00'),
(408, 66, 249, 1, '7.00', 6, NULL, '59:35', NULL, 4, 0, 111, '2022-11-10 18:23:39', '0.00'),
(409, 66, 139, 1, '7.50', 6, NULL, '59:36', NULL, 4, 0, 111, '2022-11-10 18:23:39', '0.00'),
(410, 66, 144, 1, '9.00', 6, NULL, '59:39', NULL, 9, 0, 111, '2022-11-10 18:23:39', '0.00'),
(411, 109, 228, 2, '30.00', 6, NULL, '11:40', NULL, 31, 0, 122, '2022-11-10 18:35:22', '0.00'),
(412, 109, 95, 1, '7.50', 6, NULL, '05:26', 'la esencia aparte xfa', 5, 0, 122, '2022-11-10 18:35:22', '0.00'),
(413, 109, 260, 1, '3.00', 6, NULL, '05:42', NULL, 1, 0, 122, '2022-11-10 18:35:22', '0.00'),
(414, 110, 253, 1, '5.00', 6, NULL, '16:28', NULL, 9, 0, 148, '2022-11-10 18:47:47', '0.00'),
(415, 110, 200, 2, '13.00', 6, NULL, '25:26', NULL, 3, 0, 148, '2022-11-10 18:47:47', '0.00'),
(416, 110, 99, 1, '9.50', 6, NULL, '07:51', NULL, 9, 0, 148, '2022-11-10 18:47:47', '0.00'),
(417, 110, 136, 2, '3.00', 6, NULL, '08:10', NULL, 1, 0, 148, '2022-11-10 18:47:47', '0.00'),
(418, 110, 139, 1, '7.50', 6, NULL, '07:54', NULL, 4, 0, 148, '2022-11-10 18:47:47', '0.00'),
(419, 111, 242, 1, '9.00', 6, NULL, '11:45', NULL, 5, 0, 117, '2022-11-10 18:52:31', '0.00'),
(420, 111, 198, 2, '11.00', 6, NULL, '19:28', NULL, 1, 0, 117, '2022-11-10 18:52:31', '0.00'),
(421, 111, 206, 1, '7.50', 6, NULL, '12:06', NULL, 9, 0, 117, '2022-11-10 18:52:31', '0.00'),
(422, 111, 122, 1, '12.00', 6, NULL, '08:55', NULL, 1, 0, 117, '2022-11-10 18:52:31', '0.00'),
(423, 111, 127, 2, '11.50', 6, NULL, '08:58', 'con chantilly\n', 6, 0, 117, '2022-11-10 18:52:31', '0.00'),
(424, 112, 253, 1, '5.00', 6, NULL, '09:39', NULL, 9, 0, 118, '2022-11-10 18:57:01', '0.00'),
(425, 112, 207, 1, '9.00', 6, NULL, '09:38', 'sin mayonesa\n', 10, 0, 118, '2022-11-10 18:57:01', '0.00'),
(426, 112, 99, 1, '9.50', 6, NULL, '07:54', NULL, 9, 0, 118, '2022-11-10 18:57:01', '0.00'),
(427, 112, 139, 1, '7.50', 6, NULL, '11:38', NULL, 4, 0, 118, '2022-11-10 18:57:01', '0.00'),
(428, 113, 226, 3, '20.50', 6, NULL, '26:18', NULL, 29, 0, 132, '2022-11-10 18:58:26', '0.00'),
(429, 113, 159, 2, '13.00', 6, NULL, '10:53', '', 9, 0, 132, '2022-11-10 18:58:26', '0.00'),
(430, 113, 139, 1, '7.50', 6, NULL, '10:54', 'sin helar', 4, 0, 132, '2022-11-10 19:01:18', '0.00'),
(431, 114, 245, 1, '17.00', 6, NULL, '14:12', NULL, 3, 0, 116, '2022-11-10 19:02:06', '0.00'),
(432, 114, 99, 1, '9.50', 6, NULL, '07:36', NULL, 9, 0, 116, '2022-11-10 19:02:06', '0.00'),
(433, 114, 147, 1, '3.00', 6, NULL, '07:43', NULL, 2, 0, 116, '2022-11-10 19:02:06', '0.00'),
(434, 114, 122, 1, '12.00', 6, NULL, '07:44', NULL, 1, 0, 116, '2022-11-10 19:02:06', '0.00'),
(435, 115, 207, 1, '9.00', 6, NULL, '10:47', NULL, 10, 0, 114, '2022-11-10 19:04:36', '0.00'),
(436, 115, 214, 1, '15.00', 6, NULL, '20:35', NULL, 17, 0, 114, '2022-11-10 19:04:36', '0.00'),
(437, 115, 122, 1, '12.00', 6, NULL, '05:18', 'con  chantilly', 1, 0, 114, '2022-11-10 19:04:36', '0.00'),
(438, 116, 126, 1, '13.00', 6, NULL, '13:29', NULL, 5, 0, 115, '2022-11-10 19:05:53', '0.00'),
(439, 115, 204, 1, '5.00', 6, NULL, '11:49', NULL, 7, 0, 114, '2022-11-10 19:11:22', '0.00'),
(440, 115, 99, 1, '9.50', 6, NULL, '14:41', NULL, 9, 0, 114, '2022-11-10 19:11:22', '0.00'),
(441, 74, 225, 1, '18.00', 6, NULL, '07:35', NULL, 28, 0, 120, '2022-11-10 19:14:48', '0.00'),
(442, 74, 95, 1, '7.50', 6, NULL, '55:04', NULL, 5, 0, 120, '2022-11-10 19:14:48', '0.00'),
(443, 74, 111, 1, '16.00', 6, NULL, '55:07', NULL, 21, 0, 120, '2022-11-10 19:14:48', '0.00'),
(444, 117, 198, 1, '11.00', 6, NULL, '17:33', NULL, 1, 0, 119, '2022-11-10 19:15:45', '0.00'),
(445, 117, 201, 1, '16.00', 6, NULL, '19:46', NULL, 4, 0, 119, '2022-11-10 19:15:45', '0.00'),
(446, 117, 138, 2, '6.50', 6, NULL, '13:19', '', 3, 0, 119, '2022-11-10 19:15:45', '0.00'),
(447, 110, 200, 1, '13.00', 6, NULL, '48:53', NULL, 3, 0, 148, '2022-11-10 19:19:07', '0.00'),
(448, 75, 253, 1, '5.00', 6, NULL, '52:20', NULL, 9, 0, 123, '2022-11-10 19:29:23', '0.00'),
(449, 75, 208, 1, '9.50', 6, NULL, '53:34', NULL, 11, 0, 123, '2022-11-10 19:29:23', '0.00'),
(450, 75, 95, 2, '7.50', 6, NULL, '49:12', NULL, 5, 0, 123, '2022-11-10 19:29:23', '0.00'),
(451, 66, 198, 1, '11.00', 6, NULL, '15:08', NULL, 1, 0, 127, '2022-11-10 19:36:27', '0.00'),
(452, 66, 209, 1, '10.00', 6, NULL, '15:11', NULL, 12, 0, 127, '2022-11-10 19:36:27', '0.00'),
(453, 66, 250, 2, '7.00', 6, NULL, '15:09', NULL, 1, 0, 127, '2022-11-10 19:36:27', '0.00'),
(454, 66, 141, 1, '7.50', 6, NULL, '10:05', NULL, 6, 0, 127, '2022-11-10 19:36:27', '0.00'),
(455, 118, 199, 1, '11.00', 6, NULL, '11:29', NULL, 2, 0, 121, '2022-11-10 19:37:19', '0.00'),
(456, 118, 136, 1, '3.00', 6, NULL, '06:32', NULL, 1, 0, 121, '2022-11-10 19:37:19', '0.00'),
(457, 118, 140, 1, '7.50', 6, NULL, '06:33', NULL, 5, 0, 121, '2022-11-10 19:37:19', '0.00'),
(458, 110, 182, 1, '17.00', 6, NULL, '02:36', NULL, 20, 0, 148, '2022-11-10 19:49:59', '0.00'),
(459, 110, 184, 1, '16.00', 6, NULL, '02:37', NULL, 22, 0, 148, '2022-11-10 19:49:59', '0.00'),
(460, 110, 185, 1, '16.00', 6, NULL, '02:42', NULL, 23, 0, 148, '2022-11-10 19:49:59', '0.00'),
(461, 110, 187, 1, '18.00', 6, NULL, '02:39', NULL, 25, 0, 148, '2022-11-10 19:49:59', '0.00'),
(462, 119, 198, 1, '11.00', 6, NULL, '07:10', NULL, 1, 0, 124, '2022-11-10 19:50:32', '0.00'),
(463, 119, 99, 1, '9.50', 6, NULL, '02:57', NULL, 9, 0, 124, '2022-11-10 19:50:32', '0.00'),
(464, 119, 138, 1, '6.50', 6, NULL, '03:00', NULL, 3, 0, 124, '2022-11-10 19:50:32', '0.00'),
(465, 120, 205, 1, '7.00', 6, NULL, '06:54', NULL, 8, 0, 125, '2022-11-10 19:50:57', '0.00'),
(466, 120, 213, 1, '13.00', 6, NULL, '08:36', NULL, 16, 0, 125, '2022-11-10 19:50:57', '0.00'),
(467, 120, 99, 1, '9.50', 6, NULL, '08:57', NULL, 9, 0, 125, '2022-11-10 19:50:57', '0.00'),
(468, 120, 127, 1, '11.50', 6, NULL, '08:59', 'con chantilly', 6, 0, 125, '2022-11-10 19:50:57', '0.00'),
(469, 66, 141, 1, '7.50', 6, NULL, '21:50', 'sin helar y sin azucar xfa', 6, 0, 127, '2022-11-10 19:51:48', '0.00'),
(470, 121, 198, 2, '11.00', 6, NULL, '10:14', NULL, 1, 0, 137, '2022-11-10 20:03:53', '0.00'),
(471, 121, 162, 2, '13.00', 6, NULL, '06:54', NULL, 12, 0, 137, '2022-11-10 20:03:53', '0.00'),
(472, 122, 215, 1, '8.00', 6, NULL, '16:36', NULL, 18, 0, 128, '2022-11-10 20:06:59', '0.00'),
(473, 122, 245, 1, '17.00', 6, NULL, '13:30', NULL, 3, 0, 128, '2022-11-10 20:06:59', '0.00'),
(474, 122, 127, 1, '11.50', 6, NULL, '08:40', 'in chantilly', 6, 0, 128, '2022-11-10 20:06:59', '0.00'),
(475, 122, 134, 1, '14.00', 6, NULL, '08:44', 'sin chantilly', 13, 0, 128, '2022-11-10 20:06:59', '0.00'),
(476, 122, 144, 1, '9.00', 6, NULL, '08:46', NULL, 9, 0, 128, '2022-11-10 20:06:59', '0.00'),
(477, 113, 242, 1, '9.00', 6, NULL, '25:23', NULL, 5, 0, 132, '2022-11-10 20:17:36', '0.00'),
(478, 123, 199, 1, '11.00', 6, NULL, '12:45', NULL, 2, 0, 129, '2022-11-10 20:18:17', '0.00'),
(479, 123, 129, 1, '13.00', 6, NULL, '00:50', 'sin chantilyy', 8, 0, 129, '2022-11-10 20:18:17', '0.00'),
(480, 123, 139, 1, '7.50', 6, NULL, '00:52', NULL, 4, 0, 129, '2022-11-10 20:18:17', '0.00'),
(481, 124, 209, 2, '10.00', 6, NULL, '08:57', NULL, 12, 0, 126, '2022-11-10 20:23:15', '0.00'),
(482, 124, 260, 1, '3.00', 6, NULL, '03:53', NULL, 1, 0, 126, '2022-11-10 20:23:15', '0.00'),
(483, 124, 261, 2, '3.00', 6, NULL, '03:55', NULL, 2, 0, 126, '2022-11-10 20:23:15', '0.00'),
(484, 125, 201, 1, '16.00', 6, NULL, '08:07', NULL, 4, 0, 131, '2022-11-10 20:29:23', '0.00'),
(485, 125, 208, 1, '9.50', 6, NULL, '13:04', NULL, 11, 0, 131, '2022-11-10 20:29:23', '0.00'),
(486, 125, 116, 1, '8.50', 6, NULL, '02:26', NULL, 26, 0, 131, '2022-11-10 20:29:23', '0.00'),
(487, 125, 123, 1, '13.00', 6, NULL, '02:28', 'con chantilly', 2, 0, 131, '2022-11-10 20:29:23', '0.00'),
(488, 27, 209, 2, '10.00', 6, NULL, '27:00', NULL, 12, 0, 134, '2022-11-10 20:34:03', '0.00'),
(489, 27, 250, 2, '7.00', 6, NULL, '31:21', NULL, 1, 0, 134, '2022-11-10 20:34:03', '0.00'),
(490, 126, 225, 1, '18.00', 6, NULL, '09:16', NULL, 28, 0, 136, '2022-11-10 20:42:46', '0.00'),
(491, 126, 226, 1, '20.50', 6, NULL, '09:19', NULL, 29, 0, 136, '2022-11-10 20:42:46', '0.00'),
(492, 126, 250, 1, '7.00', 6, NULL, '09:20', NULL, 1, 0, 136, '2022-11-10 20:42:46', '0.00'),
(493, 126, 118, 1, '10.00', 6, NULL, '03:16', NULL, 28, 0, 136, '2022-11-10 20:42:46', '0.00'),
(494, 127, 250, 2, '7.00', 6, NULL, '04:56', NULL, 1, 0, 130, '2022-11-10 20:47:04', '0.00'),
(495, 121, 253, 2, '5.00', 6, NULL, '48:17', NULL, 9, 0, 137, '2022-11-10 20:47:41', '0.00'),
(496, 121, 163, 2, '13.00', 6, NULL, '50:33', NULL, 13, 0, 137, '2022-11-10 20:47:41', '0.00'),
(497, 128, 127, 2, '11.50', 6, NULL, '07:51', 'con chantilly\n', 6, 0, 138, '2022-11-10 20:49:54', '0.00'),
(498, 129, 198, 2, '11.00', 6, NULL, '22:57', NULL, 1, 0, 133, '2022-11-10 20:55:04', '0.00'),
(499, 129, 217, 2, '11.00', 6, NULL, '22:56', NULL, 20, 0, 133, '2022-11-10 20:55:04', '0.00'),
(500, 129, 132, 1, '14.00', 6, NULL, '08:11', 'sin chantilly', 11, 0, 133, '2022-11-10 20:55:04', '0.00'),
(501, 130, 134, 1, '14.00', 6, NULL, '19:06', NULL, 13, 0, 135, '2022-11-10 20:55:54', '0.00'),
(502, 129, 155, 2, '11.00', 6, NULL, '12:59', NULL, 5, 0, 133, '2022-11-10 20:56:05', '0.00'),
(503, 121, 147, 1, '3.00', 6, NULL, '55:51', NULL, 2, 0, 137, '2022-11-10 20:59:32', '0.00'),
(504, 131, 228, 2, '30.00', 6, NULL, '13:31', NULL, 31, 0, 139, '2022-11-10 21:04:26', '0.00'),
(505, 131, 250, 1, '7.00', 6, NULL, '13:32', NULL, 1, 0, 139, '2022-11-10 21:04:26', '0.00'),
(506, 131, 139, 1, '7.50', 6, NULL, '12:33', NULL, 4, 0, 139, '2022-11-10 21:04:26', '0.00'),
(507, 131, 141, 1, '7.50', 6, NULL, '12:35', NULL, 6, 0, 139, '2022-11-10 21:04:26', '0.00'),
(508, 110, 182, 1, '17.00', 6, NULL, '20:06', NULL, 20, 0, 148, '2022-11-10 21:07:29', '0.00'),
(509, 110, 184, 1, '16.00', 6, NULL, '20:07', NULL, 22, 0, 148, '2022-11-10 21:07:29', '0.00'),
(510, 110, 185, 1, '16.00', 6, NULL, '20:09', NULL, 23, 0, 148, '2022-11-10 21:07:29', '0.00'),
(511, 110, 186, 1, '18.00', 6, NULL, '20:11', NULL, 24, 0, 148, '2022-11-10 21:07:29', '0.00'),
(512, 132, 99, 1, '9.50', 6, NULL, '04:52', NULL, 9, 0, 144, '2022-11-10 21:12:11', '0.00'),
(513, 132, 260, 1, '3.00', 6, NULL, '04:54', NULL, 1, 0, 144, '2022-11-10 21:12:11', '0.00'),
(514, 27, 162, 2, '13.00', 6, NULL, '29:01', NULL, 12, 0, 145, '2022-11-10 21:35:40', '0.00'),
(515, 133, 209, 1, '10.00', 6, NULL, '07:24', NULL, 12, 0, 141, '2022-11-10 21:38:15', '0.00'),
(516, 133, 99, 1, '9.50', 6, NULL, '01:28', NULL, 9, 0, 141, '2022-11-10 21:38:15', '0.00'),
(517, 133, 262, 1, '3.00', 6, NULL, '07:52', NULL, 3, 0, 141, '2022-11-10 21:38:15', '0.00'),
(518, 134, 104, 1, '8.00', 6, NULL, '04:43', NULL, 14, 0, 140, '2022-11-10 21:41:33', '0.00'),
(519, 134, 127, 1, '11.50', 6, NULL, '04:45', 'con chantilly', 6, 0, 140, '2022-11-10 21:41:33', '0.00'),
(520, 132, 260, 1, '3.00', 6, NULL, '34:09', NULL, 1, 0, 144, '2022-11-10 21:45:53', '0.00'),
(521, 110, 185, 3, '16.00', 6, NULL, '00:14', NULL, 23, 0, 148, '2022-11-10 21:47:32', '0.00'),
(522, 110, 187, 1, '18.00', 6, NULL, '00:12', NULL, 25, 0, 148, '2022-11-10 21:47:32', '0.00'),
(523, 127, 208, 1, '9.50', 6, NULL, '11:52', NULL, 11, 0, 147, '2022-11-10 21:48:05', '0.00'),
(524, 127, 225, 1, '18.00', 6, NULL, '11:55', NULL, 28, 0, 147, '2022-11-10 21:48:05', '0.00'),
(525, 127, 227, 1, '21.00', 6, NULL, '12:00', NULL, 30, 0, 147, '2022-11-10 21:48:05', '0.00'),
(526, 127, 94, 1, '6.00', 6, NULL, '07:40', NULL, 4, 0, 147, '2022-11-10 21:48:05', '0.00'),
(527, 127, 99, 1, '9.50', 6, NULL, '07:39', NULL, 9, 0, 147, '2022-11-10 21:48:05', '0.00'),
(528, 127, 132, 1, '14.00', 6, NULL, '07:42', 'con chantilolhy\n', 11, 0, 147, '2022-11-10 21:48:05', '0.00'),
(529, 127, 135, 1, '17.00', 6, NULL, '15:41', '\ncon chantilly\n', 14, 0, 147, '2022-11-10 21:55:47', '0.00'),
(530, 135, 209, 2, '10.00', 6, NULL, '08:27', NULL, 12, 0, 142, '2022-11-10 22:06:42', '0.00'),
(531, 135, 118, 2, '10.00', 6, NULL, '05:10', NULL, 28, 0, 142, '2022-11-10 22:06:42', '0.00'),
(532, 27, 184, 1, '16.00', 6, NULL, '04:27', NULL, 22, 0, 145, '2022-11-10 22:14:45', '0.00'),
(533, 27, 185, 1, '16.00', 6, NULL, '04:37', NULL, 23, 0, 145, '2022-11-10 22:14:45', '0.00'),
(534, 136, 198, 1, '11.00', 6, NULL, '26:33', NULL, 1, 0, 146, '2022-11-10 22:17:56', '0.00'),
(535, 136, 99, 1, '9.50', 6, NULL, '05:00', NULL, 9, 0, 146, '2022-11-10 22:17:56', '0.00'),
(536, 136, 118, 1, '10.00', 6, NULL, '05:02', NULL, 28, 0, 146, '2022-11-10 22:17:56', '0.00'),
(537, 137, 198, 1, '11.00', 6, NULL, '15:42', NULL, 1, 0, 143, '2022-11-10 22:22:02', '0.00'),
(538, 137, 199, 1, '11.00', 6, NULL, '15:43', NULL, 2, 0, 143, '2022-11-10 22:22:02', '0.00'),
(539, 137, 208, 1, '9.50', 6, NULL, '15:43', NULL, 11, 0, 143, '2022-11-10 22:22:02', '0.00'),
(540, 137, 250, 1, '7.00', 6, NULL, '15:46', NULL, 1, 0, 143, '2022-11-10 22:22:02', '0.00'),
(541, 137, 116, 1, '8.50', 6, NULL, '00:58', NULL, 26, 0, 143, '2022-11-10 22:22:02', '0.00'),
(542, 136, 199, 1, '11.00', 6, NULL, '26:35', NULL, 2, 0, 146, '2022-11-10 22:35:38', '0.00'),
(543, 138, 209, 1, '10.00', 6, NULL, '08:10', NULL, 12, 0, 149, '2022-11-11 17:49:07', '0.00'),
(544, 138, 99, 1, '9.50', 6, NULL, '06:38', NULL, 9, 0, 149, '2022-11-11 17:49:07', '0.00'),
(545, 138, 134, 1, '14.00', 6, NULL, '06:39', 'con chantilly\n', 13, 0, 149, '2022-11-11 17:49:07', '0.00'),
(546, 139, 127, 1, '11.50', 6, NULL, '07:18', NULL, 6, 0, 150, '2022-11-11 19:10:17', '0.00'),
(547, 139, 257, 1, '1.00', 6, NULL, '07:32', NULL, 1, 0, 150, '2022-11-11 19:10:17', '0.00'),
(548, 66, 138, 2, '6.50', 6, NULL, '52:43', 'una sin helar xfa ', 3, 0, 157, '2022-11-11 19:10:35', '0.00'),
(549, 140, 209, 2, '10.00', 6, NULL, '03:46', NULL, 12, 0, 152, '2022-11-11 19:17:31', '0.00'),
(550, 140, 122, 2, '12.00', 6, NULL, '08:46', 'con chantilly', 1, 0, 152, '2022-11-11 19:17:31', '0.00'),
(551, 141, 201, 1, '16.00', 6, NULL, '23:10', NULL, 4, 0, 160, '2022-11-11 19:19:40', '0.00'),
(552, 141, 226, 3, '20.50', 6, NULL, '23:00', NULL, 29, 0, 160, '2022-11-11 19:19:40', '0.00'),
(553, 141, 245, 1, '17.00', 6, NULL, '23:01', NULL, 3, 0, 160, '2022-11-11 19:19:40', '0.00'),
(554, 141, 147, 2, '3.00', 6, NULL, '06:51', NULL, 2, 0, 160, '2022-11-11 19:19:40', '0.00'),
(555, 141, 137, 2, '6.00', 6, NULL, '06:36', NULL, 2, 0, 160, '2022-11-11 19:19:40', '0.00'),
(556, 141, 139, 1, '7.50', 6, NULL, '06:54', NULL, 4, 0, 160, '2022-11-11 19:19:40', '0.00'),
(557, 142, 198, 1, '11.00', 6, NULL, '19:29', NULL, 1, 0, 151, '2022-11-11 19:24:57', '0.00'),
(558, 142, 126, 1, '13.00', 6, NULL, '16:41', 'con chantilly', 5, 0, 151, '2022-11-11 19:24:57', '0.00'),
(559, 142, 129, 1, '13.00', 6, NULL, '09:31', 'con chantilly', 8, 0, 151, '2022-11-11 19:24:57', '0.00'),
(560, 142, 134, 1, '14.00', 6, NULL, '09:33', 'con chantilly', 13, 0, 151, '2022-11-11 19:24:57', '0.00'),
(561, 66, 99, 1, '9.50', 6, NULL, '07:52', NULL, 9, 0, 157, '2022-11-11 19:36:24', '0.00'),
(562, 66, 118, 1, '10.00', 6, NULL, '07:53', NULL, 28, 0, 157, '2022-11-11 19:36:24', '0.00'),
(563, 143, 198, 4, '11.00', 6, NULL, '30:40', NULL, 1, 0, 155, '2022-11-11 19:45:03', '0.00'),
(564, 143, 256, 4, '1.00', 6, NULL, '30:38', NULL, 2, 0, 155, '2022-11-11 19:45:03', '0.00'),
(565, 144, 199, 1, '11.00', 6, NULL, '24:35', 'es de queso\n', 2, 0, 153, '2022-11-11 19:51:22', '0.00'),
(566, 144, 245, 1, '17.00', 6, NULL, '24:36', NULL, 3, 0, 153, '2022-11-11 19:51:22', '0.00'),
(567, 144, 167, 1, '17.00', 6, NULL, '11:35', NULL, 17, 0, 153, '2022-11-11 19:51:22', '0.00'),
(568, 144, 127, 1, '11.50', 6, NULL, '11:36', 'con chantilly\n', 6, 0, 153, '2022-11-11 19:51:22', '0.00'),
(569, 144, 142, 1, '9.00', 6, NULL, '11:39', NULL, 7, 0, 153, '2022-11-11 19:51:22', '0.00'),
(570, 145, 215, 1, '8.00', 6, NULL, '14:46', NULL, 18, 0, 154, '2022-11-11 20:10:17', '0.00'),
(571, 145, 228, 1, '30.00', 6, NULL, '05:58', NULL, 31, 0, 154, '2022-11-11 20:10:17', '0.00'),
(572, 145, 99, 1, '9.50', 6, NULL, '00:27', NULL, 9, 0, 154, '2022-11-11 20:10:17', '0.00'),
(573, 145, 260, 1, '3.00', 6, NULL, '00:30', NULL, 1, 0, 154, '2022-11-11 20:10:17', '0.00'),
(574, 66, 226, 2, '20.50', 6, NULL, '56:50', NULL, 29, 0, 157, '2022-11-11 20:12:23', '0.00'),
(575, 141, 226, 1, '20.50', 6, NULL, '56:47', NULL, 29, 0, 160, '2022-11-11 20:12:56', '0.00');
INSERT INTO `toma_pedido` (`id`, `id_pedido`, `id_producto`, `cantidad`, `precio`, `estado`, `nota`, `kpi`, `observaciones`, `item`, `timbre`, `id_facturacion`, `fecha_registro`, `descuento`) VALUES
(576, 145, 234, 1, '6.00', 6, NULL, '20:09', NULL, 6, 0, 154, '2022-11-11 20:15:36', '0.00'),
(577, 146, 99, 1, '9.50', 6, NULL, '02:47', NULL, 9, 0, 158, '2022-11-11 20:24:25', '0.00'),
(578, 146, 139, 1, '7.50', 6, NULL, '02:48', NULL, 4, 0, 158, '2022-11-11 20:24:25', '0.00'),
(579, 66, 226, 2, '20.50', 6, NULL, '13:15', NULL, 29, 0, 157, '2022-11-11 20:32:28', '0.00'),
(580, 66, 139, 1, '7.50', 6, NULL, '06:15', NULL, 4, 0, 157, '2022-11-11 20:32:28', '0.00'),
(581, 66, 140, 4, '7.50', 6, NULL, '06:18', NULL, 5, 0, 157, '2022-11-11 20:32:28', '0.00'),
(582, 66, 138, 1, '6.50', 6, NULL, '06:19', NULL, 3, 0, 157, '2022-11-11 20:37:24', '0.00'),
(583, 141, 159, 2, '13.00', 6, NULL, '27:56', NULL, 9, 0, 160, '2022-11-11 20:40:08', '0.00'),
(584, 141, 161, 1, '13.00', 6, NULL, '27:58', NULL, 11, 0, 160, '2022-11-11 20:40:08', '0.00'),
(585, 147, 237, 1, '6.00', 6, NULL, '00:37', NULL, 1, 0, 156, '2022-11-11 20:54:54', '0.00'),
(586, 148, 157, 1, '13.00', 6, NULL, '06:01', NULL, 7, 0, 164, '2022-11-11 21:03:30', '0.00'),
(587, 148, 159, 2, '13.00', 6, NULL, '06:02', NULL, 9, 0, 164, '2022-11-11 21:03:30', '0.00'),
(588, 149, 206, 1, '7.50', 6, NULL, '08:49', NULL, 9, 0, 161, '2022-11-11 21:07:14', '0.00'),
(589, 150, 226, 1, '20.50', 6, NULL, '17:08', NULL, 29, 0, 159, '2022-11-11 21:19:32', '0.00'),
(590, 150, 122, 1, '12.00', 6, NULL, '01:36', NULL, 1, 0, 159, '2022-11-11 21:19:32', '0.00'),
(591, 150, 139, 1, '7.50', 6, NULL, '01:38', NULL, 4, 0, 159, '2022-11-11 21:19:32', '0.00'),
(592, 151, 215, 2, '8.00', 6, NULL, '19:28', NULL, 18, 0, 165, '2022-11-11 21:20:59', '0.00'),
(593, 151, 135, 2, '17.00', 6, NULL, '06:03', 'con chantilly', 14, 0, 165, '2022-11-11 21:20:59', '0.00'),
(594, 148, 245, 1, '17.00', 6, NULL, '34:53', 'con chantilly', 3, 0, 164, '2022-11-11 21:26:29', '0.00'),
(595, 152, 199, 1, '11.00', 6, NULL, '20:01', NULL, 2, 0, 163, '2022-11-11 21:27:27', '0.00'),
(596, 152, 209, 1, '10.00', 6, NULL, '20:02', NULL, 12, 0, 163, '2022-11-11 21:27:27', '0.00'),
(597, 152, 226, 1, '20.50', 6, NULL, '20:09', NULL, 29, 0, 163, '2022-11-11 21:27:27', '0.00'),
(598, 152, 250, 1, '7.00', 6, NULL, '20:11', NULL, 1, 0, 163, '2022-11-11 21:27:27', '0.00'),
(599, 152, 99, 1, '9.50', 6, NULL, '04:51', NULL, 9, 0, 163, '2022-11-11 21:27:27', '0.00'),
(600, 153, 129, 2, '13.00', 6, NULL, '04:41', NULL, 8, 0, 162, '2022-11-11 21:37:18', '0.00'),
(601, 153, 124, 1, '16.00', 6, NULL, '17:02', NULL, 3, 0, 162, '2022-11-11 21:42:19', '0.00'),
(602, 148, 163, 1, '13.00', 6, NULL, '51:56', NULL, 13, 0, 164, '2022-11-11 21:42:48', '0.00'),
(603, 148, 233, 1, '5.00', 6, NULL, '00:00', NULL, 5, 0, 164, '2022-11-11 22:03:15', '0.00'),
(604, 154, 147, 1, '3.00', 6, NULL, '01:20', NULL, 2, 0, 166, '2022-11-12 17:47:00', '0.00'),
(605, 154, 127, 1, '11.50', 6, NULL, '01:19', NULL, 6, 0, 166, '2022-11-12 17:47:00', '0.00'),
(606, 155, 127, 1, '11.50', 6, NULL, '05:44', NULL, 6, 0, 185, '2022-11-12 18:14:10', '0.00'),
(607, 156, 174, 2, '8.00', 6, NULL, '00:12', NULL, 12, 0, 169, '2022-11-12 18:23:27', '0.00'),
(608, 157, 147, 1, '3.00', 6, NULL, '00:25', NULL, 2, 0, 170, '2022-11-12 18:27:23', '0.00'),
(609, 157, 198, 1, '11.00', 6, NULL, '28:13', NULL, 1, 0, 170, '2022-11-12 18:35:32', '0.00'),
(610, 157, 199, 2, '11.00', 6, NULL, '28:16', NULL, 2, 0, 170, '2022-11-12 18:35:32', '0.00'),
(611, 157, 99, 1, '9.50', 6, NULL, '16:42', NULL, 9, 0, 170, '2022-11-12 18:35:32', '0.00'),
(612, 157, 163, 2, '13.00', 6, NULL, '14:16', NULL, 13, 0, 170, '2022-11-12 18:35:32', '0.00'),
(613, 158, 253, 2, '5.00', 6, NULL, '06:45', NULL, 9, 0, 167, '2022-11-12 18:55:15', '0.00'),
(614, 158, 209, 2, '10.00', 6, NULL, '03:29', NULL, 12, 0, 167, '2022-11-12 18:55:15', '0.00'),
(615, 158, 98, 1, '7.50', 6, NULL, '00:18', NULL, 8, 0, 167, '2022-11-12 18:55:15', '0.00'),
(616, 158, 260, 1, '3.00', 6, NULL, '00:19', NULL, 1, 0, 167, '2022-11-12 18:55:15', '0.00'),
(617, 156, 174, 2, '8.00', 6, NULL, '32:17', NULL, 12, 0, 169, '2022-11-12 18:55:34', '0.00'),
(618, 159, 198, 2, '11.00', 6, NULL, '12:41', NULL, 1, 0, 176, '2022-11-12 18:58:26', '0.00'),
(619, 159, 200, 1, '13.00', 6, NULL, '12:43', NULL, 3, 0, 176, '2022-11-12 18:58:26', '0.00'),
(620, 159, 250, 3, '7.00', 6, NULL, '05:31', NULL, 1, 0, 176, '2022-11-12 18:58:26', '0.00'),
(621, 160, 206, 1, '7.50', 6, NULL, '05:43', NULL, 9, 0, 168, '2022-11-12 19:02:09', '0.00'),
(622, 160, 99, 1, '9.50', 6, NULL, '05:58', NULL, 9, 0, 168, '2022-11-12 19:02:09', '0.00'),
(623, 160, 123, 1, '13.00', 6, NULL, '06:40', 'con chantilly', 2, 0, 168, '2022-11-12 19:02:09', '0.00'),
(624, 161, 99, 1, '9.50', 6, NULL, '04:58', NULL, 9, 0, 171, '2022-11-12 19:11:20', '0.00'),
(625, 161, 118, 1, '10.00', 6, NULL, '05:00', NULL, 28, 0, 171, '2022-11-12 19:11:20', '0.00'),
(626, 162, 237, 1, '6.00', 6, NULL, '08:44', NULL, 1, 0, 173, '2022-11-12 19:21:52', '0.00'),
(627, 162, 198, 1, '11.00', 6, NULL, '08:48', NULL, 1, 0, 173, '2022-11-12 19:21:52', '0.00'),
(628, 162, 207, 1, '9.00', 6, NULL, '08:49', NULL, 10, 0, 173, '2022-11-12 19:21:52', '0.00'),
(629, 162, 209, 1, '10.00', 6, NULL, '08:51', NULL, 12, 0, 173, '2022-11-12 19:21:52', '0.00'),
(630, 162, 99, 1, '9.50', 6, NULL, '06:00', NULL, 9, 0, 173, '2022-11-12 19:21:52', '0.00'),
(631, 162, 118, 1, '10.00', 6, NULL, '06:01', NULL, 28, 0, 173, '2022-11-12 19:21:52', '0.00'),
(632, 162, 141, 1, '7.50', 6, NULL, '06:03', NULL, 6, 0, 173, '2022-11-12 19:21:52', '0.00'),
(633, 159, 250, 1, '7.00', 6, NULL, '35:03', NULL, 1, 0, 176, '2022-11-12 19:31:28', '0.00'),
(634, 162, 99, 1, '9.50', 6, NULL, '19:19', NULL, 9, 0, 173, '2022-11-12 19:34:47', '0.00'),
(635, 162, 198, 1, '11.00', 6, NULL, '22:03', NULL, 1, 0, 173, '2022-11-12 19:37:11', '0.00'),
(636, 162, 99, 1, '9.50', 6, NULL, '19:22', NULL, 9, 0, 173, '2022-11-12 19:37:11', '0.00'),
(637, 163, 245, 1, '17.00', 6, NULL, '06:00', NULL, 3, 0, 180, '2022-11-12 19:37:40', '0.00'),
(638, 163, 99, 2, '9.50', 6, NULL, '06:44', NULL, 9, 0, 180, '2022-11-12 19:37:40', '0.00'),
(639, 164, 254, 1, '5.00', 6, NULL, '13:02', NULL, 10, 0, 172, '2022-11-12 19:44:07', '0.00'),
(640, 164, 139, 1, '7.50', 6, NULL, '04:02', NULL, 4, 0, 172, '2022-11-12 19:44:07', '0.00'),
(641, 157, 157, 2, '13.00', 6, NULL, '25:24', NULL, 7, 0, 170, '2022-11-12 19:47:18', '0.00'),
(642, 164, 214, 1, '15.00', 6, NULL, '15:38', NULL, 17, 0, 172, '2022-11-12 19:52:40', '0.00'),
(643, 164, 250, 1, '7.00', 6, NULL, '12:59', NULL, 1, 0, 172, '2022-11-12 19:52:40', '0.00'),
(644, 165, 245, 1, '17.00', 6, NULL, '11:36', NULL, 3, 0, 175, '2022-11-12 20:12:38', '0.00'),
(645, 165, 127, 1, '11.50', 6, NULL, '07:20', 'con chantilly', 6, 0, 175, '2022-11-12 20:12:38', '0.00'),
(646, 165, 129, 1, '13.00', 6, NULL, '07:21', 'con chantilly', 8, 0, 175, '2022-11-12 20:12:38', '0.00'),
(647, 166, 228, 2, '30.00', 6, NULL, '24:05', NULL, 31, 0, 179, '2022-11-12 20:22:09', '0.00'),
(648, 166, 130, 1, '13.00', 6, NULL, '10:40', NULL, 9, 0, 179, '2022-11-12 20:22:09', '0.00'),
(649, 166, 132, 1, '14.00', 6, NULL, '10:43', NULL, 11, 0, 179, '2022-11-12 20:22:09', '0.00'),
(650, 163, 237, 1, '6.00', 6, NULL, '56:23', NULL, 1, 0, 180, '2022-11-12 20:24:50', '0.00'),
(651, 167, 228, 2, '30.00', 6, NULL, '20:53', NULL, 31, 0, 177, '2022-11-12 20:25:27', '0.00'),
(652, 167, 95, 1, '7.50', 6, NULL, '05:50', NULL, 5, 0, 177, '2022-11-12 20:25:27', '0.00'),
(653, 167, 116, 1, '8.50', 6, NULL, '05:52', NULL, 26, 0, 177, '2022-11-12 20:25:27', '0.00'),
(654, 163, 157, 1, '13.00', 6, NULL, '07:16', NULL, 7, 0, 180, '2022-11-12 20:29:44', '0.00'),
(655, 163, 185, 1, '16.00', 6, NULL, '07:18', NULL, 23, 0, 180, '2022-11-12 20:29:44', '0.00'),
(656, 168, 237, 1, '6.00', 6, NULL, '04:27', NULL, 1, 0, 178, '2022-11-12 20:30:33', '0.00'),
(657, 168, 122, 1, '12.00', 6, NULL, '10:24', 'chanti', 1, 0, 178, '2022-11-12 20:30:33', '0.00'),
(658, 168, 131, 1, '13.00', 6, NULL, '10:25', 'chantully', 10, 0, 178, '2022-11-12 20:30:33', '0.00'),
(659, 166, 147, 1, '3.00', 6, NULL, '22:51', NULL, 2, 0, 179, '2022-11-12 20:42:55', '0.00'),
(660, 169, 253, 1, '5.00', 6, NULL, '09:27', NULL, 9, 0, 183, '2022-11-12 20:47:10', '0.00'),
(661, 169, 209, 6, '10.00', 6, NULL, '09:24', NULL, 12, 0, 183, '2022-11-12 20:47:10', '0.00'),
(662, 169, 116, 1, '8.50', 6, NULL, '20:00', NULL, 26, 0, 183, '2022-11-12 20:47:10', '0.00'),
(663, 169, 163, 7, '13.00', 6, NULL, '20:03', NULL, 13, 0, 183, '2022-11-12 20:47:10', '0.00'),
(664, 169, 139, 4, '7.50', 6, NULL, '20:01', NULL, 4, 0, 183, '2022-11-12 20:47:10', '0.00'),
(665, 170, 238, 3, '15.00', 6, NULL, '28:10', NULL, 2, 0, 181, '2022-11-12 20:52:20', '0.00'),
(666, 170, 206, 2, '7.50', 6, NULL, '28:12', NULL, 9, 0, 181, '2022-11-12 20:52:20', '0.00'),
(667, 170, 228, 2, '30.00', 6, NULL, '28:14', NULL, 31, 0, 181, '2022-11-12 20:52:20', '0.00'),
(668, 170, 250, 3, '7.00', 6, NULL, '28:16', NULL, 1, 0, 181, '2022-11-12 20:52:20', '0.00'),
(669, 171, 245, 1, '17.00', 6, NULL, '14:44', NULL, 3, 0, 186, '2022-11-12 20:54:14', '0.00'),
(670, 171, 163, 2, '13.00', 6, NULL, '13:02', NULL, 13, 0, 186, '2022-11-12 20:54:14', '0.00'),
(671, 172, 228, 2, '30.00', 6, NULL, '20:29', NULL, 31, 0, 182, '2022-11-12 21:14:53', '0.00'),
(672, 172, 140, 1, '7.50', 6, NULL, '08:15', NULL, 5, 0, 182, '2022-11-12 21:14:53', '0.00'),
(673, 172, 142, 1, '9.00', 6, NULL, '09:11', NULL, 7, 0, 182, '2022-11-12 21:14:53', '0.00'),
(674, 171, 163, 2, '13.00', 6, NULL, '59:27', NULL, 13, 0, 186, '2022-11-12 21:43:12', '0.00'),
(675, 172, 255, 1, '1.50', 4, NULL, NULL, NULL, 1, 0, NULL, '2022-11-12 21:55:49', '0.00'),
(676, 173, 209, 1, '10.00', 6, NULL, '05:44', NULL, 12, 0, 184, '2022-11-12 22:07:25', '0.00'),
(677, 173, 99, 1, '9.50', 6, NULL, '04:58', NULL, 9, 0, 184, '2022-11-12 22:07:25', '0.00'),
(678, 173, 139, 1, '7.50', 6, NULL, '04:59', NULL, 4, 0, 184, '2022-11-12 22:07:25', '0.00'),
(679, 174, 127, 2, '11.50', 6, NULL, '23:11', 'con chantilly \npoco chantilly\n', 6, 0, 187, '2022-11-13 16:47:57', '0.00'),
(680, 175, 173, 1, '7.00', 6, NULL, '03:50', NULL, 11, 0, 188, '2022-11-13 17:34:45', '0.00'),
(681, 176, 199, 1, '11.00', 6, NULL, '14:40', NULL, 2, 0, 189, '2022-11-13 17:39:35', '0.00'),
(682, 176, 163, 1, '13.00', 6, NULL, '15:12', NULL, 13, 0, 189, '2022-11-13 17:39:35', '0.00'),
(683, 176, 164, 1, '15.00', 6, NULL, '15:13', NULL, 14, 0, 189, '2022-11-13 17:39:35', '0.00'),
(684, 177, 209, 2, '10.00', 6, NULL, '01:50', NULL, 12, 0, 190, '2022-11-13 18:46:16', '0.00'),
(685, 177, 250, 2, '7.00', 6, NULL, '01:52', NULL, 1, 0, 190, '2022-11-13 18:46:16', '0.00'),
(686, 178, 118, 2, '10.00', 6, NULL, '05:30', NULL, 28, 0, 191, '2022-11-13 18:47:10', '0.00'),
(687, 179, 209, 1, '10.00', 6, NULL, '03:04', NULL, 12, 0, 192, '2022-11-13 18:53:27', '0.00'),
(688, 179, 157, 1, '13.00', 6, NULL, '06:30', NULL, 7, 0, 192, '2022-11-13 18:53:27', '0.00'),
(689, 179, 163, 1, '13.00', 6, NULL, '06:32', NULL, 13, 0, 192, '2022-11-13 18:53:27', '0.00'),
(690, 179, 139, 1, '7.50', 6, NULL, '08:17', NULL, 4, 0, 192, '2022-11-13 18:53:27', '0.00'),
(691, 180, 99, 1, '9.50', 6, NULL, '03:57', NULL, 9, 0, 198, '2022-11-13 18:53:38', '0.00'),
(692, 180, 141, 1, '7.50', 6, NULL, '03:56', 'solo piña', 6, 0, 198, '2022-11-13 18:53:38', '0.00'),
(693, 180, 198, 2, '11.00', 6, NULL, '30:10', NULL, 1, 0, 198, '2022-11-13 19:10:19', '0.00'),
(694, 181, 236, 1, '7.00', 6, NULL, '17:03', NULL, 8, 0, 193, '2022-11-13 19:14:18', '0.00'),
(695, 181, 226, 2, '20.50', 6, NULL, '17:00', NULL, 29, 0, 193, '2022-11-13 19:14:18', '0.00'),
(696, 181, 147, 1, '3.00', 6, NULL, '03:49', NULL, 2, 0, 193, '2022-11-13 19:14:18', '0.00'),
(697, 181, 136, 1, '3.00', 6, NULL, '03:48', NULL, 1, 0, 193, '2022-11-13 19:14:18', '0.00'),
(698, 179, 165, 1, '15.00', 6, NULL, '35:55', NULL, 15, 0, 192, '2022-11-13 19:23:22', '0.00'),
(699, 179, 167, 1, '17.00', 6, NULL, '36:38', NULL, 17, 0, 192, '2022-11-13 19:23:22', '0.00'),
(700, 180, 99, 1, '9.50', 6, NULL, '39:07', NULL, 9, 0, 198, '2022-11-13 19:24:34', '0.00'),
(701, 182, 253, 1, '5.00', 6, NULL, '10:26', NULL, 9, 0, 204, '2022-11-13 19:26:23', '0.00'),
(702, 182, 254, 1, '5.00', 6, NULL, '10:31', NULL, 10, 0, 204, '2022-11-13 19:26:23', '0.00'),
(703, 182, 99, 2, '9.50', 6, NULL, '08:58', NULL, 9, 0, 204, '2022-11-13 19:26:23', '0.00'),
(704, 183, 226, 1, '20.50', 6, NULL, '16:07', '', 29, 0, 197, '2022-11-13 19:32:49', '0.00'),
(705, 183, 122, 1, '12.00', 6, NULL, '11:47', 'con chantilly', 1, 0, 197, '2022-11-13 19:32:49', '0.00'),
(706, 184, 226, 1, '20.50', 6, NULL, '00:48', '', 29, 0, 197, '2022-11-13 19:32:49', '0.00'),
(707, 184, 122, 1, '12.00', 6, NULL, '11:48', 'con chamntilly\n', 1, 0, 197, '2022-11-13 19:32:49', '0.00'),
(708, 185, 253, 2, '5.00', 6, NULL, '21:21', NULL, 9, 0, 194, '2022-11-13 19:33:31', '0.00'),
(709, 185, 254, 2, '5.00', 6, NULL, '21:24', NULL, 10, 0, 194, '2022-11-13 19:33:31', '0.00'),
(710, 185, 198, 1, '11.00', 6, NULL, '21:58', NULL, 1, 0, 194, '2022-11-13 19:33:31', '0.00'),
(711, 185, 204, 1, '5.00', 6, NULL, '26:27', NULL, 7, 0, 194, '2022-11-13 19:33:31', '0.00'),
(712, 185, 217, 1, '11.00', 6, NULL, '26:36', NULL, 20, 0, 194, '2022-11-13 19:33:31', '0.00'),
(713, 185, 221, 1, '9.50', 6, NULL, '21:55', NULL, 24, 0, 194, '2022-11-13 19:33:31', '0.00'),
(714, 185, 225, 1, '18.00', 6, NULL, '21:49', NULL, 28, 0, 194, '2022-11-13 19:33:31', '0.00'),
(715, 185, 228, 1, '30.00', 6, NULL, '26:39', NULL, 31, 0, 194, '2022-11-13 19:33:31', '0.00'),
(716, 185, 250, 2, '7.00', 6, NULL, '26:33', NULL, 1, 0, 194, '2022-11-13 19:33:31', '0.00'),
(717, 185, 195, 1, '6.00', 6, NULL, '17:44', NULL, 35, 0, 194, '2022-11-13 19:33:31', '0.00'),
(718, 185, 132, 2, '14.00', 6, NULL, '19:52', NULL, 11, 0, 194, '2022-11-13 19:33:31', '0.00'),
(719, 185, 139, 1, '7.50', 6, NULL, '17:41', NULL, 4, 0, 194, '2022-11-13 19:33:31', '0.00'),
(720, 185, 260, 1, '3.00', 6, NULL, '19:51', NULL, 1, 0, 194, '2022-11-13 19:33:31', '0.00'),
(721, 180, 141, 1, '7.50', 6, NULL, '06:46', 'solo piña\nsin helar', 6, 0, 198, '2022-11-13 19:38:16', '0.00'),
(722, 186, 198, 2, '11.00', 6, NULL, '28:26', NULL, 1, 0, 196, '2022-11-13 19:41:01', '0.00'),
(723, 186, 199, 1, '11.00', 6, NULL, '28:27', NULL, 2, 0, 196, '2022-11-13 19:41:01', '0.00'),
(724, 186, 213, 1, '13.00', 6, NULL, '24:51', NULL, 16, 0, 196, '2022-11-13 19:41:01', '0.00'),
(725, 186, 95, 1, '7.50', 6, NULL, '28:07', NULL, 5, 0, 196, '2022-11-13 19:41:01', '0.00'),
(726, 186, 99, 1, '9.50', 6, NULL, '23:31', NULL, 9, 0, 196, '2022-11-13 19:41:01', '0.00'),
(727, 186, 117, 1, '8.00', 6, NULL, '19:27', NULL, 27, 0, 196, '2022-11-13 19:41:01', '0.00'),
(728, 186, 127, 1, '11.50', 6, NULL, '22:12', 'con chantilly', 6, 0, 196, '2022-11-13 19:41:01', '0.00'),
(729, 171, 151, 2, '7.00', 6, NULL, '12:53', NULL, 1, 0, 200, '2022-11-13 20:03:52', '0.00'),
(730, 187, 198, 1, '11.00', 6, NULL, '19:46', NULL, 1, 0, 199, '2022-11-13 20:10:29', '0.00'),
(731, 187, 263, 1, '3.00', 6, NULL, '00:06', NULL, 4, 0, 199, '2022-11-13 20:10:29', '0.00'),
(732, 187, 245, 1, '17.00', 6, NULL, '19:47', NULL, 3, 0, 199, '2022-11-13 20:16:03', '0.00'),
(733, 187, 138, 1, '6.50', 6, NULL, '08:46', 'sin helar', 3, 0, 199, '2022-11-13 20:16:03', '0.00'),
(734, 188, 198, 1, '11.00', 6, NULL, '03:06', NULL, 1, 0, 195, '2022-11-13 20:16:09', '0.00'),
(735, 188, 255, 1, '1.50', 6, NULL, '03:03', NULL, 1, 0, 195, '2022-11-13 20:16:09', '0.00'),
(736, 189, 129, 1, '13.00', 6, NULL, '06:42', 'con  chantilly\n', 8, 0, 203, '2022-11-13 20:41:35', '0.00'),
(737, 189, 132, 1, '14.00', 6, NULL, '06:44', 'con chantilly', 11, 0, 203, '2022-11-13 20:41:35', '0.00'),
(738, 190, 198, 1, '11.00', 6, NULL, '07:14', NULL, 1, 0, 201, '2022-11-13 20:47:39', '0.00'),
(739, 190, 199, 1, '11.00', 6, NULL, '13:37', NULL, 2, 0, 201, '2022-11-13 20:47:39', '0.00'),
(740, 190, 119, 1, '5.00', 6, NULL, '07:31', 'No hay en cocina ', 1, 0, 201, '2022-11-13 20:47:39', '0.00'),
(741, 190, 120, 1, '7.00', 6, NULL, '13:27', NULL, 2, 0, 201, '2022-11-13 20:47:39', '0.00'),
(742, 191, 198, 1, '11.00', 6, NULL, '12:29', NULL, 1, 0, 202, '2022-11-13 20:48:50', '0.00'),
(743, 191, 118, 1, '10.00', 6, NULL, '04:13', NULL, 28, 0, 202, '2022-11-13 20:48:50', '0.00'),
(744, 190, 120, 1, '7.00', 6, NULL, '13:33', NULL, 2, 0, 201, '2022-11-13 20:49:23', '0.00'),
(745, 192, 160, 2, '13.00', 6, NULL, '09:13', NULL, 10, 0, 205, '2022-11-13 20:52:24', '0.00'),
(746, 192, 122, 2, '12.00', 6, NULL, '06:53', NULL, 1, 0, 205, '2022-11-13 20:52:24', '0.00'),
(747, 190, 198, 1, '11.00', 6, NULL, '25:03', NULL, 1, 0, 201, '2022-11-13 21:03:26', '0.00'),
(748, 192, 255, 1, '1.50', 6, NULL, '20:21', NULL, 1, 0, 205, '2022-11-13 21:11:54', '0.00'),
(749, 192, 237, 1, '6.00', 4, NULL, '40:06', NULL, 1, 0, NULL, '2022-11-13 21:26:08', '0.00'),
(750, 192, 110, 1, '20.00', 4, NULL, NULL, NULL, 20, 0, NULL, '2022-11-13 21:26:08', '0.00'),
(751, 193, 205, 1, '7.00', 6, NULL, '02:55', NULL, 8, 0, 210, '2022-11-13 21:34:10', '0.00'),
(752, 193, 99, 1, '9.50', 6, NULL, '04:50', NULL, 9, 0, 210, '2022-11-13 21:34:10', '0.00'),
(753, 194, 237, 1, '6.00', 6, NULL, '00:17', NULL, 1, 0, 206, '2022-11-13 21:40:33', '0.00'),
(754, 194, 110, 1, '20.00', 6, NULL, '00:12', NULL, 20, 0, 206, '2022-11-13 21:40:33', '0.00'),
(755, 171, 139, 1, '7.50', 6, NULL, '57:01', 'con menta', 4, 0, 207, '2022-11-13 21:42:33', '0.00'),
(756, 171, 140, 1, '7.50', 6, NULL, '00:07', NULL, 5, 0, 207, '2022-11-13 21:42:33', '0.00'),
(757, 171, 198, 1, '11.00', 6, NULL, '02:34', NULL, 1, 0, 207, '2022-11-13 21:45:33', '0.00'),
(758, 195, 206, 1, '7.50', 6, NULL, '09:51', NULL, 9, 0, 209, '2022-11-13 21:47:03', '0.00'),
(759, 195, 122, 2, '12.00', 6, NULL, '12:51', NULL, 1, 0, 209, '2022-11-13 21:47:03', '0.00'),
(760, 196, 124, 1, '16.00', 6, NULL, '12:52', 'sin chantilly', 3, 0, 208, '2022-11-13 21:54:50', '0.00'),
(761, 196, 126, 1, '13.00', 6, NULL, '12:54', 'sin cha', 5, 0, 208, '2022-11-13 21:54:50', '0.00'),
(762, 196, 198, 1, '11.00', 6, NULL, '19:41', NULL, 1, 0, 208, '2022-11-13 22:02:09', '0.00'),
(763, 197, 199, 1, '11.00', 6, NULL, '13:56', NULL, 2, 0, 211, '2022-11-13 22:21:56', '0.00'),
(764, 197, 206, 1, '7.50', 6, NULL, '06:05', NULL, 9, 0, 211, '2022-11-13 22:21:56', '0.00'),
(765, 197, 129, 1, '13.00', 6, NULL, '05:23', NULL, 8, 0, 211, '2022-11-13 22:21:56', '0.00'),
(766, 197, 134, 1, '14.00', 6, NULL, '08:45', 'con chantilly', 13, 0, 211, '2022-11-13 22:21:56', '0.00'),
(767, 198, 253, 1, '5.00', 6, NULL, '08:56', NULL, 9, 0, 212, '2022-11-13 22:27:02', '0.00'),
(768, 198, 124, 1, '16.00', 6, NULL, '07:24', NULL, 3, 0, 212, '2022-11-13 22:27:02', '0.00'),
(769, 198, 144, 1, '9.00', 6, NULL, '03:41', NULL, 9, 0, 212, '2022-11-13 22:27:02', '0.00'),
(770, 199, 199, 1, '11.00', 6, NULL, '14:12', NULL, 2, 0, 213, '2022-11-14 16:41:43', '0.00'),
(771, 199, 245, 1, '17.00', 6, NULL, '11:05', NULL, 3, 0, 213, '2022-11-14 16:41:43', '0.00'),
(772, 199, 129, 1, '13.00', 6, NULL, '38:59', NULL, 8, 0, 213, '2022-11-14 16:41:43', '0.00'),
(773, 200, 135, 1, '17.00', 6, NULL, '36:20', NULL, 14, 0, 214, '2022-11-14 16:44:26', '0.00'),
(774, 200, 257, 1, '1.00', 6, NULL, '36:18', NULL, 1, 0, 214, '2022-11-14 16:44:26', '0.00'),
(775, 201, 99, 2, '9.50', 6, NULL, '32:11', NULL, 9, 0, 215, '2022-11-14 16:48:33', '0.00'),
(776, 199, 122, 1, '12.00', 6, NULL, '39:04', NULL, 1, 0, 213, '2022-11-14 16:51:57', '0.00'),
(777, 201, 209, 2, '10.00', 6, NULL, '26:33', NULL, 12, 0, 215, '2022-11-14 17:00:52', '0.00'),
(778, 202, 209, 1, '10.00', 6, NULL, '02:39', NULL, 12, 0, 216, '2022-11-14 17:35:43', '0.00'),
(779, 202, 144, 2, '9.00', 6, NULL, '05:01', NULL, 9, 0, 216, '2022-11-14 17:36:01', '0.00'),
(780, 203, 199, 1, '11.00', 6, NULL, '00:25', NULL, 2, 0, 223, '2022-11-14 17:38:07', '0.00'),
(781, 203, 206, 1, '7.50', 6, NULL, '00:27', NULL, 9, 0, 223, '2022-11-14 17:38:07', '0.00'),
(782, 203, 147, 1, '3.00', 6, NULL, '02:28', NULL, 2, 0, 223, '2022-11-14 17:38:07', '0.00'),
(783, 203, 177, 1, '8.50', 6, NULL, '02:35', NULL, 15, 0, 223, '2022-11-14 17:38:07', '0.00'),
(784, 203, 179, 3, '11.00', 6, NULL, '02:31', NULL, 17, 0, 223, '2022-11-14 17:38:07', '0.00'),
(785, 203, 125, 1, '18.00', 6, NULL, '02:33', NULL, 4, 0, 223, '2022-11-14 17:38:07', '0.00'),
(786, 203, 144, 1, '9.00', 6, NULL, '02:32', NULL, 9, 0, 223, '2022-11-14 17:38:07', '0.00'),
(787, 203, 261, 1, '3.00', 6, NULL, '05:13', NULL, 2, 0, 223, '2022-11-14 17:38:07', '0.00'),
(788, 204, 127, 1, '11.50', 6, NULL, '33:02', NULL, 6, 0, 217, '2022-11-14 17:39:51', '0.00'),
(789, 204, 128, 1, '15.00', 6, NULL, '33:03', NULL, 7, 0, 217, '2022-11-14 17:39:51', '0.00'),
(790, 204, 129, 2, '13.00', 6, NULL, '33:05', NULL, 8, 0, 217, '2022-11-14 17:39:51', '0.00'),
(791, 204, 134, 1, '14.00', 6, NULL, '33:09', NULL, 13, 0, 217, '2022-11-14 17:39:51', '0.00'),
(792, 204, 257, 5, '1.00', 6, NULL, '33:06', NULL, 1, 0, 217, '2022-11-14 17:39:51', '0.00'),
(793, 205, 226, 2, '20.50', 6, NULL, '22:23', NULL, 29, 0, 219, '2022-11-14 17:50:34', '0.00'),
(794, 205, 228, 1, '30.00', 6, NULL, '22:26', NULL, 31, 0, 219, '2022-11-14 17:50:34', '0.00'),
(795, 205, 99, 1, '9.50', 6, NULL, '22:29', NULL, 9, 0, 219, '2022-11-14 17:50:34', '0.00'),
(796, 205, 164, 1, '15.00', 6, NULL, '22:32', NULL, 14, 0, 219, '2022-11-14 17:50:34', '0.00'),
(797, 205, 132, 1, '14.00', 6, NULL, '22:33', 'con chantilly', 11, 0, 219, '2022-11-14 17:50:34', '0.00'),
(798, 205, 228, 1, '30.00', 6, NULL, '22:22', NULL, 31, 0, 219, '2022-11-14 17:55:06', '0.00'),
(799, 205, 261, 1, '3.00', 6, NULL, '22:36', NULL, 2, 0, 219, '2022-11-14 17:55:06', '0.00'),
(800, 206, 253, 1, '5.00', 6, NULL, '07:16', NULL, 9, 0, 218, '2022-11-14 18:18:53', '0.00'),
(801, 206, 237, 2, '6.00', 6, NULL, '05:51', NULL, 1, 0, 218, '2022-11-14 18:18:53', '0.00'),
(802, 206, 99, 3, '9.50', 6, NULL, '07:16', NULL, 9, 0, 218, '2022-11-14 18:18:53', '0.00'),
(803, 203, 179, 3, '11.00', 6, NULL, '48:18', NULL, 17, 0, 223, '2022-11-14 18:21:30', '0.00'),
(804, 207, 253, 6, '5.00', 6, NULL, '14:25', NULL, 9, 0, 220, '2022-11-14 18:27:14', '0.00'),
(805, 207, 262, 6, '3.00', 6, NULL, '05:36', NULL, 3, 0, 220, '2022-11-14 18:27:14', '0.00'),
(806, 205, 164, 3, '15.00', 6, NULL, '57:56', NULL, 14, 0, 219, '2022-11-14 18:41:37', '0.00'),
(807, 205, 147, 1, '3.00', 6, NULL, '57:58', NULL, 2, 0, 219, '2022-11-14 18:41:37', '0.00'),
(808, 208, 215, 1, '8.00', 6, NULL, '10:39', NULL, 18, 0, 222, '2022-11-14 18:44:33', '0.00'),
(809, 208, 221, 1, '9.50', 6, NULL, '10:41', NULL, 24, 0, 222, '2022-11-14 18:44:33', '0.00'),
(810, 208, 99, 1, '9.50', 6, NULL, '16:36', '', 9, 0, 222, '2022-11-14 18:44:33', '0.00'),
(811, 209, 225, 2, '18.00', 6, NULL, '09:15', NULL, 28, 0, 221, '2022-11-14 18:47:03', '0.00'),
(812, 209, 118, 1, '10.00', 6, NULL, '14:11', NULL, 28, 0, 221, '2022-11-14 18:47:03', '0.00'),
(813, 209, 147, 1, '3.00', 6, NULL, '14:08', NULL, 2, 0, 221, '2022-11-14 18:47:03', '0.00'),
(814, 209, 129, 1, '13.00', 6, NULL, '14:13', 'con chantilly', 8, 0, 221, '2022-11-14 18:47:03', '0.00'),
(815, 208, 118, 1, '10.00', 6, NULL, '16:37', '', 28, 0, 222, '2022-11-14 18:50:12', '0.00'),
(816, 210, 209, 2, '10.00', 6, NULL, '04:13', NULL, 12, 0, 224, '2022-11-14 19:04:29', '0.00'),
(817, 210, 94, 1, '6.00', 6, NULL, '05:08', NULL, 4, 0, 224, '2022-11-14 19:04:29', '0.00'),
(818, 210, 99, 1, '9.50', 6, NULL, '14:57', NULL, 9, 0, 224, '2022-11-14 19:04:29', '0.00'),
(819, 211, 253, 2, '5.00', 6, NULL, '01:13', NULL, 9, 0, 228, '2022-11-14 19:09:24', '0.00'),
(820, 211, 95, 1, '7.50', 6, NULL, '10:08', NULL, 5, 0, 228, '2022-11-14 19:09:24', '0.00'),
(821, 211, 118, 1, '10.00', 6, NULL, '10:10', NULL, 28, 0, 228, '2022-11-14 19:09:24', '0.00'),
(822, 212, 95, 1, '7.50', 6, NULL, '06:04', NULL, 5, 0, 233, '2022-11-14 19:13:41', '0.00'),
(823, 212, 99, 1, '9.50', 6, NULL, '06:05', NULL, 9, 0, 233, '2022-11-14 19:13:41', '0.00'),
(824, 212, 123, 1, '13.00', 6, NULL, '06:07', NULL, 2, 0, 233, '2022-11-14 19:13:41', '0.00'),
(825, 213, 253, 1, '5.00', 6, NULL, '10:21', NULL, 9, 0, 226, '2022-11-14 19:19:21', '0.00'),
(826, 213, 198, 1, '11.00', 6, NULL, '18:58', NULL, 1, 0, 226, '2022-11-14 19:19:21', '0.00'),
(827, 213, 95, 1, '7.50', 6, NULL, '03:19', NULL, 5, 0, 226, '2022-11-14 19:19:21', '0.00'),
(828, 213, 99, 1, '9.50', 6, NULL, '03:21', NULL, 9, 0, 226, '2022-11-14 19:19:21', '0.00'),
(829, 214, 201, 2, '16.00', 6, NULL, '16:06', NULL, 4, 0, 230, '2022-11-14 19:23:05', '0.00'),
(830, 214, 95, 1, '7.50', 6, NULL, '03:29', NULL, 5, 0, 230, '2022-11-14 19:23:05', '0.00'),
(831, 214, 99, 1, '9.50', 6, NULL, '03:31', NULL, 9, 0, 230, '2022-11-14 19:23:05', '0.00'),
(832, 211, 253, 1, '5.00', 6, NULL, '19:11', NULL, 9, 0, 228, '2022-11-14 19:24:34', '0.00'),
(833, 210, 209, 1, '10.00', 6, NULL, '40:33', NULL, 12, 0, 224, '2022-11-14 19:26:49', '0.00'),
(834, 210, 224, 1, '15.00', 6, NULL, '38:41', NULL, 27, 0, 224, '2022-11-14 19:26:49', '0.00'),
(835, 210, 118, 2, '10.00', 6, NULL, '31:42', NULL, 28, 0, 224, '2022-11-14 19:26:49', '0.00'),
(836, 203, 179, 2, '11.00', 6, NULL, '01:18', NULL, 17, 0, 223, '2022-11-14 19:32:59', '0.00'),
(837, 215, 198, 1, '11.00', 6, NULL, '17:56', NULL, 1, 0, 235, '2022-11-14 19:35:01', '0.00'),
(838, 215, 228, 1, '30.00', 6, NULL, '21:58', NULL, 31, 0, 235, '2022-11-14 19:35:01', '0.00'),
(839, 215, 250, 1, '7.00', 6, NULL, '22:15', NULL, 1, 0, 235, '2022-11-14 19:35:01', '0.00'),
(840, 215, 118, 1, '10.00', 6, NULL, '03:39', NULL, 28, 0, 235, '2022-11-14 19:35:01', '0.00'),
(841, 213, 253, 1, '5.00', 6, NULL, '37:22', NULL, 9, 0, 226, '2022-11-14 19:35:15', '0.00'),
(842, 213, 228, 1, '30.00', 6, NULL, '37:32', NULL, 31, 0, 226, '2022-11-14 19:35:15', '0.00'),
(843, 216, 209, 1, '10.00', 6, NULL, '08:46', 'SIN JUGO\n', 12, 0, 237, '2022-11-14 19:37:11', '0.00'),
(844, 216, 99, 1, '9.50', 6, NULL, '06:53', NULL, 9, 0, 237, '2022-11-14 19:37:11', '0.00'),
(845, 217, 226, 2, '20.50', 6, NULL, '16:40', NULL, 29, 0, 236, '2022-11-14 19:40:30', '0.00'),
(846, 217, 250, 1, '7.00', 6, NULL, '16:43', NULL, 1, 0, 236, '2022-11-14 19:40:30', '0.00'),
(847, 217, 99, 1, '9.50', 6, NULL, '03:37', NULL, 9, 0, 236, '2022-11-14 19:40:30', '0.00'),
(848, 217, 262, 1, '3.00', 6, NULL, '13:23', NULL, 3, 0, 236, '2022-11-14 19:40:30', '0.00'),
(849, 215, 198, 1, '11.00', 6, NULL, '17:58', NULL, 1, 0, 235, '2022-11-14 19:42:00', '0.00'),
(850, 215, 250, 1, '7.00', 6, NULL, '09:55', NULL, 1, 0, 235, '2022-11-14 19:42:00', '0.00'),
(851, 218, 129, 2, '13.00', 6, NULL, '11:24', NULL, 8, 0, 227, '2022-11-14 19:43:22', '0.00'),
(852, 218, 134, 1, '14.00', 6, NULL, '13:59', NULL, 13, 0, 227, '2022-11-14 19:43:22', '0.00'),
(853, 219, 198, 2, '11.00', 6, NULL, '09:38', NULL, 1, 0, 225, '2022-11-14 19:52:46', '0.00'),
(854, 219, 209, 1, '10.00', 6, NULL, '07:52', NULL, 12, 0, 225, '2022-11-14 19:52:46', '0.00'),
(855, 219, 118, 2, '10.00', 6, NULL, '15:56', NULL, 28, 0, 225, '2022-11-14 19:52:46', '0.00'),
(856, 219, 139, 1, '7.50', 6, NULL, '15:57', 'SIN HELAR', 4, 0, 225, '2022-11-14 19:52:46', '0.00'),
(857, 220, 198, 1, '11.00', 6, NULL, '09:46', NULL, 1, 0, 229, '2022-11-14 19:56:57', '0.00'),
(858, 220, 212, 1, '11.50', 6, NULL, '09:45', NULL, 15, 0, 229, '2022-11-14 19:56:57', '0.00'),
(859, 220, 118, 1, '10.00', 6, NULL, '00:25', NULL, 28, 0, 229, '2022-11-14 19:56:57', '0.00'),
(860, 220, 165, 1, '15.00', 6, NULL, '13:58', NULL, 15, 0, 229, '2022-11-14 19:56:57', '0.00'),
(861, 216, 215, 1, '8.00', 6, NULL, '39:24', NULL, 18, 0, 237, '2022-11-14 19:57:39', '0.00'),
(862, 213, 141, 2, '7.50', 6, NULL, '49:23', 'NO MUY DULCES\n', 6, 0, 226, '2022-11-14 20:01:18', '0.00'),
(863, 220, 147, 1, '3.00', 6, NULL, '13:59', NULL, 2, 0, 229, '2022-11-14 20:08:09', '0.00'),
(864, 221, 253, 1, '5.00', 6, NULL, '06:48', NULL, 9, 0, 232, '2022-11-14 20:11:35', '0.00'),
(865, 221, 198, 1, '11.00', 6, NULL, '33:30', NULL, 1, 0, 232, '2022-11-14 20:11:35', '0.00'),
(866, 221, 199, 1, '11.00', 6, NULL, '11:54', NULL, 2, 0, 232, '2022-11-14 20:11:35', '0.00'),
(867, 221, 95, 1, '7.50', 6, NULL, '04:54', NULL, 5, 0, 232, '2022-11-14 20:11:35', '0.00'),
(868, 221, 99, 1, '9.50', 6, NULL, '04:56', NULL, 9, 0, 232, '2022-11-14 20:11:35', '0.00'),
(869, 221, 256, 1, '1.00', 6, NULL, '33:32', NULL, 2, 0, 232, '2022-11-14 20:20:12', '0.00'),
(870, 222, 206, 1, '7.50', 6, NULL, '23:27', NULL, 9, 0, 231, '2022-11-14 20:21:43', '0.00'),
(871, 222, 208, 2, '9.50', 6, NULL, '23:33', NULL, 11, 0, 231, '2022-11-14 20:21:43', '0.00'),
(872, 222, 99, 2, '9.50', 6, NULL, '20:26', NULL, 9, 0, 231, '2022-11-14 20:21:43', '0.00'),
(873, 222, 261, 1, '3.00', 6, NULL, '20:27', NULL, 2, 0, 231, '2022-11-14 20:21:43', '0.00'),
(874, 216, 139, 1, '7.50', 6, NULL, '04:54', NULL, 4, 0, 237, '2022-11-14 20:22:32', '0.00'),
(875, 223, 207, 1, '9.00', 6, NULL, '11:36', NULL, 10, 0, 251, '2022-11-14 20:45:35', '0.00'),
(876, 223, 209, 1, '10.00', 6, NULL, '11:39', NULL, 12, 0, 251, '2022-11-14 20:45:35', '0.00'),
(877, 223, 226, 1, '20.50', 6, NULL, '15:26', NULL, 29, 0, 251, '2022-11-14 20:45:35', '0.00'),
(878, 223, 95, 1, '7.50', 6, NULL, '07:29', NULL, 5, 0, 251, '2022-11-14 20:45:35', '0.00'),
(879, 223, 134, 2, '14.00', 6, NULL, '07:32', 'los dos con chantilly pero uno con poquito chantilly', 13, 0, 251, '2022-11-14 20:45:35', '0.00'),
(880, 223, 262, 1, '3.00', 6, NULL, '11:32', NULL, 3, 0, 251, '2022-11-14 20:45:35', '0.00'),
(881, 184, 238, 1, '15.00', 6, NULL, '33:06', NULL, 2, 0, 244, '2022-11-14 20:46:45', '0.00'),
(882, 184, 206, 1, '7.50', 6, NULL, '24:19', NULL, 9, 0, 244, '2022-11-14 20:46:45', '0.00'),
(883, 217, 262, 1, '3.00', 6, NULL, '11:30', NULL, 3, 0, 236, '2022-11-14 20:48:18', '0.00'),
(884, 215, 243, 1, '9.00', 6, NULL, '14:26', NULL, 1, 0, 235, '2022-11-14 20:49:01', '0.00'),
(885, 215, 118, 1, '10.00', 6, NULL, '16:56', NULL, 28, 0, 235, '2022-11-14 20:49:01', '0.00'),
(886, 215, 141, 1, '7.50', 6, NULL, '18:08', NULL, 6, 0, 235, '2022-11-14 20:49:01', '0.00'),
(887, 216, 228, 1, '30.00', 6, NULL, '28:49', NULL, 31, 0, 237, '2022-11-14 20:50:04', '0.00'),
(888, 216, 139, 1, '7.50', 6, NULL, '19:53', NULL, 4, 0, 237, '2022-11-14 20:50:04', '0.00'),
(889, 184, 95, 1, '7.50', 6, NULL, '18:37', NULL, 5, 0, 244, '2022-11-14 20:50:25', '0.00'),
(890, 224, 198, 2, '11.00', 6, NULL, '17:48', '', 1, 0, 234, '2022-11-14 20:51:54', '0.00'),
(891, 224, 256, 2, '1.00', 6, NULL, '17:49', '', 2, 0, 234, '2022-11-14 20:51:54', '0.00'),
(892, 225, 199, 2, '11.00', 6, NULL, '12:11', NULL, 2, 0, 238, '2022-11-14 20:58:46', '0.00'),
(893, 225, 99, 1, '9.50', 6, NULL, '03:16', NULL, 9, 0, 238, '2022-11-14 20:58:46', '0.00'),
(894, 226, 238, 1, '15.00', 6, NULL, '21:49', NULL, 2, 0, 240, '2022-11-14 20:58:48', '0.00'),
(895, 226, 209, 1, '10.00', 6, NULL, '21:51', NULL, 12, 0, 240, '2022-11-14 20:58:48', '0.00'),
(896, 226, 99, 1, '9.50', 6, NULL, '03:16', NULL, 9, 0, 240, '2022-11-14 20:58:48', '0.00'),
(897, 171, 225, 1, '18.00', 6, NULL, '16:13', NULL, 28, 0, 239, '2022-11-14 20:59:38', '0.00'),
(898, 171, 141, 2, '7.50', 6, NULL, '13:05', 'solo naranja ', 6, 0, 239, '2022-11-14 20:59:38', '0.00'),
(899, 227, 132, 1, '14.00', 6, NULL, '09:13', NULL, 11, 0, 243, '2022-11-14 21:05:18', '0.00'),
(900, 227, 135, 1, '17.00', 6, NULL, '09:15', NULL, 14, 0, 243, '2022-11-14 21:05:18', '0.00'),
(901, 228, 238, 1, '15.00', 6, NULL, '10:29', NULL, 2, 0, 242, '2022-11-14 21:15:33', '0.00'),
(902, 228, 198, 2, '11.00', 6, NULL, '10:34', NULL, 1, 0, 242, '2022-11-14 21:15:33', '0.00'),
(903, 228, 147, 1, '3.00', 6, NULL, '00:39', NULL, 2, 0, 242, '2022-11-14 21:15:33', '0.00'),
(904, 223, 125, 1, '18.00', 6, NULL, '46:59', 'con chantilly', 4, 0, 251, '2022-11-14 21:23:34', '0.00'),
(905, 229, 206, 1, '7.50', 6, NULL, '14:41', NULL, 9, 0, 248, '2022-11-14 21:26:10', '0.00'),
(906, 229, 226, 1, '20.50', 6, NULL, '14:19', NULL, 29, 0, 248, '2022-11-14 21:26:10', '0.00'),
(907, 229, 250, 1, '7.00', 6, NULL, '14:39', NULL, 1, 0, 248, '2022-11-14 21:26:10', '0.00'),
(908, 229, 262, 1, '3.00', 6, NULL, '08:44', NULL, 3, 0, 248, '2022-11-14 21:26:10', '0.00'),
(909, 226, 99, 1, '9.50', 6, NULL, '41:21', NULL, 9, 0, 240, '2022-11-14 21:28:29', '0.00'),
(910, 230, 127, 2, '11.50', 6, NULL, '09:47', NULL, 6, 0, 241, '2022-11-14 21:30:24', '0.00'),
(911, 230, 257, 2, '1.00', 6, NULL, '09:49', NULL, 1, 0, 241, '2022-11-14 21:30:24', '0.00'),
(912, 231, 237, 1, '6.00', 6, NULL, '10:56', NULL, 1, 0, 245, '2022-11-14 21:30:44', '0.00'),
(913, 231, 210, 1, '11.00', 6, NULL, '09:48', NULL, 13, 0, 245, '2022-11-14 21:30:44', '0.00'),
(914, 231, 250, 1, '7.00', 6, NULL, '10:03', NULL, 1, 0, 245, '2022-11-14 21:30:44', '0.00'),
(915, 231, 95, 1, '7.50', 6, NULL, '07:20', NULL, 5, 0, 245, '2022-11-14 21:30:44', '0.00'),
(916, 223, 139, 1, '7.50', 6, NULL, '47:00', NULL, 4, 0, 251, '2022-11-14 21:31:08', '0.00'),
(917, 229, 99, 1, '9.50', 6, NULL, '14:06', NULL, 9, 0, 248, '2022-11-14 21:35:00', '0.00'),
(918, 231, 118, 1, '10.00', 6, NULL, '11:26', NULL, 28, 0, 245, '2022-11-14 21:41:14', '0.00'),
(919, 232, 198, 1, '11.00', 6, NULL, '11:43', NULL, 1, 0, 246, '2022-11-14 21:45:43', '0.00'),
(920, 232, 205, 2, '7.00', 6, NULL, '08:01', NULL, 8, 0, 246, '2022-11-14 21:45:43', '0.00'),
(921, 232, 98, 1, '7.50', 6, NULL, '15:15', NULL, 8, 0, 246, '2022-11-14 21:45:43', '0.00'),
(922, 231, 199, 1, '11.00', 6, NULL, '26:46', NULL, 2, 0, 245, '2022-11-14 21:46:01', '0.00'),
(923, 171, 201, 1, '16.00', 6, NULL, '07:47', NULL, 4, 0, 253, '2022-11-14 21:51:00', '0.00'),
(924, 171, 206, 2, '7.50', 6, NULL, '06:45', NULL, 9, 0, 253, '2022-11-14 21:51:00', '0.00'),
(925, 171, 250, 1, '7.00', 6, NULL, '07:48', NULL, 1, 0, 253, '2022-11-14 21:51:00', '0.00'),
(926, 171, 156, 1, '13.00', 6, NULL, '15:03', NULL, 6, 0, 253, '2022-11-14 21:51:00', '0.00'),
(927, 171, 159, 1, '13.00', 6, NULL, '15:38', NULL, 9, 0, 253, '2022-11-14 21:51:00', '0.00'),
(928, 233, 199, 1, '11.00', 6, NULL, '22:27', NULL, 2, 0, 247, '2022-11-14 21:55:49', '0.00'),
(929, 233, 209, 1, '10.00', 6, NULL, '22:24', NULL, 12, 0, 247, '2022-11-14 21:55:49', '0.00'),
(930, 233, 127, 3, '11.50', 6, NULL, '14:02', 'con chantilly', 6, 0, 247, '2022-11-14 21:55:49', '0.00'),
(931, 184, 199, 2, '11.00', 6, NULL, '45:11', NULL, 2, 0, 244, '2022-11-14 22:00:29', '0.00'),
(932, 184, 256, 2, '1.00', 6, NULL, '45:12', NULL, 2, 0, 244, '2022-11-14 22:00:48', '0.00'),
(933, 234, 198, 1, '11.00', 6, NULL, '13:38', NULL, 1, 0, 252, '2022-11-14 22:04:17', '0.00'),
(934, 234, 200, 1, '13.00', 6, NULL, '13:48', NULL, 3, 0, 252, '2022-11-14 22:04:17', '0.00'),
(935, 234, 99, 1, '9.50', 6, NULL, '12:59', NULL, 9, 0, 252, '2022-11-14 22:04:17', '0.00'),
(936, 234, 147, 1, '3.00', 6, NULL, '13:04', NULL, 2, 0, 252, '2022-11-14 22:04:17', '0.00'),
(937, 234, 139, 1, '7.50', 6, NULL, '13:01', 'FRESCA', 4, 0, 252, '2022-11-14 22:04:17', '0.00'),
(938, 234, 143, 1, '9.00', 6, NULL, '13:00', 'SIN HELAR \nSIN AZUCAR', 8, 0, 252, '2022-11-14 22:04:17', '0.00'),
(939, 235, 228, 2, '30.00', 6, NULL, '12:55', NULL, 31, 0, 250, '2022-11-14 22:05:28', '0.00'),
(940, 235, 250, 1, '7.00', 6, NULL, '13:07', NULL, 1, 0, 250, '2022-11-14 22:05:28', '0.00'),
(941, 235, 139, 3, '7.50', 6, NULL, '11:46', NULL, 4, 0, 250, '2022-11-14 22:05:28', '0.00'),
(942, 232, 148, 1, '5.00', 6, NULL, '24:00', NULL, 3, 0, 246, '2022-11-14 22:07:45', '0.00'),
(943, 236, 129, 1, '13.00', 6, NULL, '11:57', NULL, 8, 0, 249, '2022-11-14 22:17:29', '0.00'),
(944, 236, 132, 1, '14.00', 6, NULL, '22:48', NULL, 11, 0, 249, '2022-11-14 22:17:29', '0.00'),
(945, 223, 148, 1, '5.00', 6, NULL, '54:40', NULL, 3, 0, 251, '2022-11-14 22:30:08', '0.00'),
(946, 237, 239, 2, '7.50', 6, NULL, '17:09', NULL, 1, 0, 255, '2022-11-15 17:32:46', '0.00'),
(947, 237, 127, 2, '11.50', 6, NULL, '17:10', NULL, 6, 0, 255, '2022-11-15 17:32:46', '0.00'),
(948, 238, 198, 1, '11.00', 6, NULL, '16:09', NULL, 1, 0, 254, '2022-11-15 17:38:58', '0.00'),
(949, 238, 208, 1, '9.50', 6, NULL, '16:12', NULL, 11, 0, 254, '2022-11-15 17:38:58', '0.00'),
(950, 238, 95, 1, '7.50', 6, NULL, '11:00', NULL, 5, 0, 254, '2022-11-15 17:38:58', '0.00'),
(951, 238, 99, 1, '9.50', 6, NULL, '11:02', NULL, 9, 0, 254, '2022-11-15 17:38:58', '0.00'),
(952, 237, 237, 2, '6.00', 6, NULL, '25:33', NULL, 1, 0, 255, '2022-11-15 17:44:11', '0.00'),
(953, 239, 198, 1, '11.00', 6, NULL, '12:37', NULL, 1, 0, 256, '2022-11-15 17:51:36', '0.00'),
(954, 239, 199, 1, '11.00', 6, NULL, '12:38', NULL, 2, 0, 256, '2022-11-15 17:51:36', '0.00'),
(955, 239, 214, 1, '15.00', 6, NULL, '12:39', NULL, 17, 0, 256, '2022-11-15 17:51:36', '0.00'),
(956, 239, 250, 1, '7.00', 6, NULL, '12:40', NULL, 1, 0, 256, '2022-11-15 17:51:36', '0.00'),
(957, 239, 92, 1, '5.50', 6, NULL, '11:32', NULL, 2, 0, 256, '2022-11-15 17:51:36', '0.00'),
(958, 239, 118, 1, '10.00', 6, NULL, '11:34', NULL, 28, 0, 256, '2022-11-15 17:51:36', '0.00'),
(959, 240, 209, 2, '10.00', 6, NULL, '06:37', NULL, 12, 0, 257, '2022-11-15 18:07:31', '0.00'),
(960, 240, 250, 2, '7.00', 6, NULL, '06:38', NULL, 1, 0, 257, '2022-11-15 18:07:31', '0.00'),
(961, 239, 198, 6, '11.00', 6, NULL, '34:01', NULL, 1, 0, 256, '2022-11-15 18:12:55', '0.00'),
(962, 239, 256, 6, '1.00', 6, NULL, '34:02', NULL, 2, 0, 256, '2022-11-15 18:12:55', '0.00'),
(963, 239, 247, 3, '1.00', 6, NULL, '21:57', NULL, 2, 0, 256, '2022-11-15 18:12:55', '0.00'),
(964, 241, 140, 1, '7.50', 6, NULL, '32:39', NULL, 5, 0, 259, '2022-11-15 18:35:31', '0.00'),
(965, 241, 201, 2, '16.00', 6, NULL, '26:27', NULL, 4, 0, 259, '2022-11-15 18:50:47', '0.00'),
(966, 241, 256, 2, '1.00', 6, NULL, '26:28', NULL, 2, 0, 259, '2022-11-15 18:50:47', '0.00'),
(967, 241, 139, 1, '7.50', 6, NULL, '32:40', NULL, 4, 0, 259, '2022-11-15 18:50:47', '0.00'),
(968, 242, 253, 2, '5.00', 6, NULL, '06:14', NULL, 9, 0, 260, '2022-11-15 19:02:04', '0.00'),
(969, 242, 127, 2, '11.50', 6, NULL, '06:05', 'con chantilly', 6, 0, 260, '2022-11-15 19:02:04', '0.00'),
(970, 243, 209, 2, '10.00', 6, NULL, '05:20', NULL, 12, 0, 258, '2022-11-15 19:04:14', '0.00'),
(971, 243, 141, 2, '7.50', 6, NULL, '16:04', NULL, 6, 0, 258, '2022-11-15 19:04:14', '0.00'),
(972, 241, 245, 1, '17.00', 6, NULL, '11:44', NULL, 3, 0, 259, '2022-11-15 19:33:34', '0.00'),
(973, 244, 225, 1, '18.00', 6, NULL, '20:04', NULL, 28, 0, 261, '2022-11-15 19:53:49', '0.00'),
(974, 244, 228, 1, '30.00', 6, NULL, '20:13', NULL, 31, 0, 261, '2022-11-15 19:53:49', '0.00'),
(975, 244, 118, 2, '10.00', 6, NULL, '12:56', NULL, 28, 0, 261, '2022-11-15 19:53:49', '0.00'),
(976, 245, 209, 1, '10.00', 6, NULL, '07:22', NULL, 12, 0, 265, '2022-11-15 20:06:45', '0.00'),
(977, 245, 99, 1, '9.50', 6, NULL, '03:25', NULL, 9, 0, 265, '2022-11-15 20:06:45', '0.00'),
(978, 246, 198, 2, '11.00', 6, NULL, '11:49', NULL, 1, 0, 262, '2022-11-15 20:17:18', '0.00'),
(979, 246, 261, 1, '3.00', 6, NULL, '02:49', NULL, 2, 0, 262, '2022-11-15 20:17:18', '0.00'),
(980, 246, 262, 1, '3.00', 6, NULL, '02:51', NULL, 3, 0, 262, '2022-11-15 20:17:18', '0.00'),
(981, 247, 225, 1, '18.00', 6, NULL, '09:18', NULL, 28, 0, 264, '2022-11-15 20:34:17', '0.00'),
(982, 247, 99, 1, '9.50', 6, NULL, '07:39', NULL, 9, 0, 264, '2022-11-15 20:34:17', '0.00'),
(983, 247, 118, 1, '10.00', 6, NULL, '07:40', NULL, 28, 0, 264, '2022-11-15 20:34:17', '0.00'),
(984, 248, 209, 2, '10.00', 6, NULL, '06:14', NULL, 12, 0, 263, '2022-11-15 20:35:19', '0.00'),
(985, 248, 95, 2, '7.50', 6, NULL, '06:42', NULL, 5, 0, 263, '2022-11-15 20:35:19', '0.00'),
(986, 245, 260, 1, '3.00', 6, NULL, '38:06', NULL, 1, 0, 265, '2022-11-15 20:44:33', '0.00'),
(987, 249, 198, 1, '11.00', 6, NULL, '12:51', NULL, 1, 0, 266, '2022-11-15 20:52:59', '0.00'),
(988, 249, 199, 1, '11.00', 6, NULL, '12:52', NULL, 2, 0, 266, '2022-11-15 20:52:59', '0.00'),
(989, 249, 256, 2, '1.00', 6, NULL, '12:53', NULL, 2, 0, 266, '2022-11-15 20:52:59', '0.00'),
(990, 249, 99, 2, '9.50', 6, NULL, '14:38', NULL, 9, 0, 266, '2022-11-15 20:53:45', '0.00'),
(991, 249, 258, 2, '1.00', 6, NULL, '14:40', NULL, 2, 0, 266, '2022-11-15 20:53:45', '0.00'),
(992, 250, 206, 2, '7.50', 6, NULL, '11:29', NULL, 9, 0, 270, '2022-11-15 20:54:30', '0.00'),
(993, 250, 104, 1, '8.00', 6, NULL, '13:14', NULL, 14, 0, 270, '2022-11-15 20:54:30', '0.00'),
(994, 250, 118, 1, '10.00', 6, NULL, '25:48', NULL, 28, 0, 270, '2022-11-15 20:54:30', '0.00'),
(995, 251, 228, 1, '30.00', 6, NULL, '19:32', NULL, 31, 0, 268, '2022-11-15 20:58:05', '0.00'),
(996, 251, 99, 3, '9.50', 6, NULL, '09:40', NULL, 9, 0, 268, '2022-11-15 20:58:05', '0.00'),
(997, 252, 198, 2, '11.00', 6, NULL, '16:36', NULL, 1, 0, 269, '2022-11-15 21:06:03', '0.00'),
(998, 252, 215, 1, '8.00', 6, NULL, '16:37', NULL, 18, 0, 269, '2022-11-15 21:06:03', '0.00'),
(999, 252, 127, 3, '11.50', 6, NULL, '14:19', NULL, 6, 0, 269, '2022-11-15 21:06:03', '0.00'),
(1000, 252, 134, 1, '14.00', 6, NULL, '14:21', NULL, 13, 0, 269, '2022-11-15 21:06:03', '0.00'),
(1001, 251, 209, 1, '10.00', 6, NULL, '23:30', NULL, 12, 0, 268, '2022-11-15 21:06:23', '0.00'),
(1002, 252, 198, 1, '11.00', 6, NULL, '16:38', NULL, 1, 0, 269, '2022-11-15 21:07:01', '0.00'),
(1003, 253, 242, 1, '9.00', 6, NULL, '09:58', NULL, 5, 0, 267, '2022-11-15 21:17:17', '0.00'),
(1004, 253, 198, 1, '11.00', 6, NULL, '06:02', NULL, 1, 0, 267, '2022-11-15 21:17:17', '0.00'),
(1005, 253, 118, 2, '10.00', 6, NULL, '11:02', NULL, 28, 0, 267, '2022-11-15 21:17:17', '0.00'),
(1006, 250, 104, 1, '8.00', 6, NULL, '34:04', NULL, 14, 0, 270, '2022-11-15 21:21:50', '0.00'),
(1007, 184, 201, 1, '16.00', 6, NULL, '05:04', NULL, 4, 0, 272, '2022-11-15 21:27:49', '0.00'),
(1008, 184, 209, 1, '10.00', 6, NULL, '05:05', NULL, 12, 0, 272, '2022-11-15 21:27:49', '0.00'),
(1009, 184, 99, 1, '9.50', 6, NULL, '01:40', NULL, 9, 0, 272, '2022-11-15 21:27:49', '0.00'),
(1010, 184, 127, 1, '11.50', 6, NULL, '01:42', NULL, 6, 0, 272, '2022-11-15 21:27:49', '0.00'),
(1011, 254, 242, 1, '9.00', 6, NULL, '05:19', NULL, 5, 0, 271, '2022-11-15 21:33:33', '0.00'),
(1012, 254, 122, 1, '12.00', 6, NULL, '08:58', 'con chantilly', 1, 0, 271, '2022-11-15 21:33:33', '0.00'),
(1013, 252, 99, 1, '9.50', 6, NULL, '37:07', NULL, 9, 0, 269, '2022-11-15 21:38:47', '0.00'),
(1014, 255, 254, 2, '5.00', 6, NULL, '13:48', NULL, 10, 0, 273, '2022-11-15 22:02:53', '0.00'),
(1015, 255, 99, 2, '9.50', 6, NULL, '04:50', NULL, 9, 0, 273, '2022-11-15 22:02:53', '0.00'),
(1016, 256, 228, 2, '30.00', 6, NULL, '18:07', NULL, 31, 0, 274, '2022-11-15 22:25:39', '0.00'),
(1017, 256, 250, 2, '7.00', 6, NULL, '18:10', NULL, 1, 0, 274, '2022-11-15 22:25:39', '0.00'),
(1018, 256, 228, 1, '30.00', 6, NULL, '31:07', NULL, 31, 0, 274, '2022-11-15 22:56:33', '0.00'),
(1019, 256, 124, 1, '16.00', 6, NULL, '31:32', NULL, 3, 0, 274, '2022-11-15 22:56:33', '0.00'),
(1020, 257, 254, 1, '5.00', 6, NULL, '14:14', NULL, 10, 0, 276, '2022-11-16 17:46:13', '0.00'),
(1021, 257, 237, 1, '6.00', 6, NULL, '10:53', NULL, 1, 0, 276, '2022-11-16 17:46:13', '0.00'),
(1022, 257, 199, 2, '11.00', 6, NULL, '14:21', NULL, 2, 0, 276, '2022-11-16 17:46:13', '0.00'),
(1023, 257, 99, 3, '9.50', 6, NULL, '14:18', NULL, 9, 0, 276, '2022-11-16 17:46:13', '0.00'),
(1024, 258, 253, 2, '5.00', 6, NULL, '13:21', NULL, 9, 0, 275, '2022-11-16 17:53:05', '0.00'),
(1025, 258, 99, 2, '9.50', 6, NULL, '07:29', NULL, 9, 0, 275, '2022-11-16 17:53:05', '0.00'),
(1026, 259, 198, 2, '11.00', 6, NULL, '08:54', NULL, 1, 0, 277, '2022-11-16 18:00:32', '0.00'),
(1027, 259, 256, 2, '1.00', 6, NULL, '09:03', NULL, 2, 0, 277, '2022-11-16 18:00:32', '0.00'),
(1028, 260, 237, 1, '6.00', 6, NULL, '01:11', NULL, 1, 0, 278, '2022-11-16 18:08:12', '0.00'),
(1029, 260, 206, 1, '7.50', 6, NULL, '07:29', NULL, 9, 0, 278, '2022-11-16 18:08:12', '0.00'),
(1030, 261, 237, 1, '6.00', 6, NULL, '08:17', NULL, 1, 0, 281, '2022-11-16 18:18:25', '0.00'),
(1031, 261, 238, 1, '15.00', 6, NULL, '08:41', NULL, 2, 0, 281, '2022-11-16 18:18:25', '0.00'),
(1032, 261, 139, 2, '7.50', 6, NULL, '06:00', NULL, 4, 0, 281, '2022-11-16 18:18:25', '0.00'),
(1033, 262, 225, 1, '18.00', 6, NULL, '06:28', NULL, 28, 0, 292, '2022-11-16 18:19:12', '0.00'),
(1034, 262, 95, 2, '7.50', 6, NULL, '05:16', NULL, 5, 0, 292, '2022-11-16 18:19:12', '0.00'),
(1035, 263, 199, 1, '11.00', 6, NULL, '12:16', NULL, 2, 0, 279, '2022-11-16 18:22:33', '0.00'),
(1036, 263, 103, 1, '12.00', 6, NULL, '01:57', NULL, 13, 0, 279, '2022-11-16 18:22:33', '0.00'),
(1037, 263, 116, 1, '8.50', 6, NULL, '11:32', NULL, 26, 0, 279, '2022-11-16 18:22:33', '0.00'),
(1038, 263, 127, 1, '11.50', 6, NULL, '11:34', NULL, 6, 0, 279, '2022-11-16 18:22:33', '0.00'),
(1039, 262, 225, 1, '18.00', 6, NULL, '16:55', NULL, 28, 0, 292, '2022-11-16 18:31:44', '0.00'),
(1040, 264, 253, 1, '5.00', 6, NULL, '07:57', NULL, 9, 0, 280, '2022-11-16 18:57:52', '0.00'),
(1041, 264, 254, 1, '5.00', 6, NULL, '11:21', NULL, 10, 0, 280, '2022-11-16 18:57:52', '0.00'),
(1042, 264, 242, 1, '9.00', 6, NULL, '05:45', NULL, 5, 0, 280, '2022-11-16 18:57:52', '0.00'),
(1043, 264, 99, 2, '9.50', 6, NULL, '08:23', NULL, 9, 0, 280, '2022-11-16 18:57:52', '0.00'),
(1044, 261, 254, 1, '5.00', 6, NULL, '09:20', NULL, 10, 0, 281, '2022-11-16 19:16:34', '0.00'),
(1045, 261, 145, 1, '10.00', 6, NULL, '02:57', NULL, 29, 0, 281, '2022-11-16 19:16:34', '0.00'),
(1046, 265, 207, 1, '9.00', 6, NULL, '29:10', NULL, 10, 0, 294, '2022-11-16 19:17:42', '0.00'),
(1047, 265, 228, 3, '30.00', 6, NULL, '29:18', NULL, 31, 0, 294, '2022-11-16 19:17:42', '0.00'),
(1048, 265, 100, 1, '7.00', 6, NULL, '34:56', NULL, 10, 0, 294, '2022-11-16 19:19:39', '0.00'),
(1049, 265, 163, 4, '13.00', 6, NULL, '22:04', NULL, 13, 0, 294, '2022-11-16 19:19:39', '0.00'),
(1050, 265, 139, 3, '7.50', 6, NULL, '22:05', NULL, 4, 0, 294, '2022-11-16 19:19:39', '0.00'),
(1051, 266, 217, 1, '11.00', 6, NULL, '24:07', NULL, 20, 0, 286, '2022-11-16 19:22:28', '0.00'),
(1052, 266, 225, 1, '18.00', 6, NULL, '13:22', NULL, 28, 0, 286, '2022-11-16 19:22:28', '0.00'),
(1053, 266, 228, 1, '30.00', 6, NULL, '13:25', NULL, 31, 0, 286, '2022-11-16 19:22:28', '0.00'),
(1054, 266, 139, 2, '7.50', 6, NULL, '17:13', NULL, 4, 0, 286, '2022-11-16 19:22:28', '0.00'),
(1055, 267, 237, 2, '6.00', 6, NULL, '19:04', NULL, 1, 0, 282, '2022-11-16 19:29:48', '0.00'),
(1056, 267, 225, 3, '18.00', 6, NULL, '06:08', NULL, 28, 0, 282, '2022-11-16 19:29:48', '0.00'),
(1057, 267, 99, 3, '9.50', 6, NULL, '09:55', NULL, 9, 0, 282, '2022-11-16 19:29:48', '0.00'),
(1058, 268, 198, 1, '11.00', 6, NULL, '18:44', NULL, 1, 0, 283, '2022-11-16 19:41:22', '0.00'),
(1059, 268, 209, 9, '10.00', 6, NULL, '18:43', NULL, 12, 0, 283, '2022-11-16 19:41:22', '0.00'),
(1060, 268, 256, 1, '1.00', 6, NULL, '18:46', NULL, 2, 0, 283, '2022-11-16 19:41:22', '0.00'),
(1061, 268, 95, 9, '7.50', 6, NULL, '11:13', NULL, 5, 0, 283, '2022-11-16 19:41:22', '0.00'),
(1062, 268, 258, 9, '1.00', 6, NULL, '11:14', NULL, 2, 0, 283, '2022-11-16 19:41:22', '0.00'),
(1063, 171, 227, 1, '21.00', 6, NULL, '11:25', NULL, 30, 0, 287, '2022-11-16 19:41:44', '0.00'),
(1064, 171, 228, 1, '30.00', 6, NULL, '11:28', NULL, 31, 0, 287, '2022-11-16 19:41:44', '0.00'),
(1065, 171, 95, 1, '7.50', 6, NULL, '51:44', NULL, 5, 0, 287, '2022-11-16 19:41:44', '0.00'),
(1066, 171, 260, 2, '3.00', 6, NULL, '51:46', NULL, 1, 0, 287, '2022-11-16 19:41:44', '0.00'),
(1067, 262, 253, 1, '5.00', 6, NULL, '49:20', '', 9, 0, 292, '2022-11-16 19:45:05', '0.00'),
(1068, 262, 95, 2, '7.50', 6, NULL, '33:14', NULL, 5, 0, 292, '2022-11-16 19:45:05', '0.00'),
(1069, 265, 207, 1, '9.00', 6, NULL, '29:19', NULL, 10, 0, 294, '2022-11-16 19:46:06', '0.00'),
(1070, 262, 198, 2, '11.00', 6, NULL, '46:21', NULL, 1, 0, 292, '2022-11-16 19:48:00', '0.00'),
(1071, 267, 99, 1, '9.50', 6, NULL, '30:52', NULL, 9, 0, 282, '2022-11-16 19:48:09', '0.00'),
(1072, 269, 126, 1, '13.00', 6, NULL, '19:14', NULL, 5, 0, 284, '2022-11-16 19:55:14', '0.00'),
(1073, 269, 127, 1, '11.50', 6, NULL, '19:13', NULL, 6, 0, 284, '2022-11-16 19:55:14', '0.00'),
(1074, 269, 257, 2, '1.00', 6, NULL, '19:14', NULL, 1, 0, 284, '2022-11-16 19:55:14', '0.00'),
(1075, 270, 228, 2, '30.00', 6, NULL, '25:19', NULL, 31, 0, 285, '2022-11-16 20:01:46', '0.00'),
(1076, 270, 261, 2, '3.00', 6, NULL, '09:30', NULL, 2, 0, 285, '2022-11-16 20:01:46', '0.00'),
(1077, 171, 95, 1, '7.50', 6, NULL, '22:26', NULL, 5, 0, 287, '2022-11-16 20:07:12', '0.00'),
(1078, 171, 260, 1, '3.00', 6, NULL, '22:28', NULL, 1, 0, 287, '2022-11-16 20:14:37', '0.00'),
(1079, 271, 254, 1, '5.00', 6, NULL, '27:09', NULL, 10, 0, 289, '2022-11-16 20:18:08', '0.00'),
(1080, 271, 199, 1, '11.00', 6, NULL, '27:10', NULL, 2, 0, 289, '2022-11-16 20:18:08', '0.00'),
(1081, 271, 207, 1, '9.00', 6, NULL, '27:11', NULL, 10, 0, 289, '2022-11-16 20:18:08', '0.00'),
(1082, 271, 225, 2, '18.00', 6, NULL, '27:23', NULL, 28, 0, 289, '2022-11-16 20:18:08', '0.00'),
(1083, 271, 226, 2, '20.50', 6, NULL, '27:15', NULL, 29, 0, 289, '2022-11-16 20:18:08', '0.00'),
(1084, 271, 227, 2, '21.00', 6, NULL, '27:12', NULL, 30, 0, 289, '2022-11-16 20:18:08', '0.00'),
(1085, 271, 250, 1, '7.00', 6, NULL, '27:16', NULL, 1, 0, 289, '2022-11-16 20:18:08', '0.00'),
(1086, 271, 256, 1, '1.00', 6, NULL, '27:16', NULL, 2, 0, 289, '2022-11-16 20:18:08', '0.00'),
(1087, 271, 99, 4, '9.50', 6, NULL, '19:17', NULL, 9, 0, 289, '2022-11-16 20:18:08', '0.00'),
(1088, 271, 118, 5, '10.00', 6, NULL, '19:18', NULL, 28, 0, 289, '2022-11-16 20:18:08', '0.00'),
(1089, 271, 225, 1, '18.00', 6, NULL, '27:25', NULL, 28, 0, 289, '2022-11-16 20:20:44', '0.00'),
(1090, 271, 99, 1, '9.50', 6, NULL, '19:21', NULL, 9, 0, 289, '2022-11-16 20:20:44', '0.00'),
(1091, 270, 253, 1, '5.00', 6, NULL, '25:20', NULL, 9, 0, 285, '2022-11-16 20:21:57', '0.00'),
(1092, 272, 210, 1, '11.00', 6, NULL, '13:36', NULL, 13, 0, 290, '2022-11-16 20:31:59', '0.00'),
(1093, 272, 122, 2, '12.00', 6, NULL, '05:33', NULL, 1, 0, 290, '2022-11-16 20:31:59', '0.00'),
(1094, 273, 209, 2, '10.00', 6, NULL, '08:04', NULL, 12, 0, 295, '2022-11-16 21:08:20', '0.00'),
(1095, 273, 250, 1, '7.00', 6, NULL, '08:08', NULL, 1, 0, 295, '2022-11-16 21:08:20', '0.00'),
(1096, 273, 141, 1, '7.50', 6, NULL, '04:52', 'piña sola', 6, 0, 295, '2022-11-16 21:08:20', '0.00'),
(1097, 273, 262, 1, '3.00', 6, NULL, '04:54', NULL, 3, 0, 295, '2022-11-16 21:08:20', '0.00'),
(1098, 274, 122, 1, '12.00', 6, NULL, '07:19', NULL, 1, 0, 293, '2022-11-16 21:16:24', '0.00'),
(1099, 274, 127, 1, '11.50', 6, NULL, '07:22', NULL, 6, 0, 293, '2022-11-16 21:16:24', '0.00'),
(1100, 275, 118, 1, '10.00', 6, NULL, '06:35', NULL, 28, 0, 288, '2022-11-16 21:17:13', '0.00'),
(1101, 275, 258, 1, '1.00', 6, NULL, '06:50', NULL, 2, 0, 288, '2022-11-16 21:17:13', '0.00'),
(1102, 262, 99, 2, '9.50', 6, NULL, '11:57', NULL, 9, 0, 292, '2022-11-16 21:25:44', '0.00'),
(1103, 273, 141, 1, '7.50', 6, NULL, '40:23', NULL, 6, 0, 295, '2022-11-16 21:32:49', '0.00'),
(1104, 276, 99, 1, '9.50', 6, NULL, '13:58', NULL, 9, 0, 296, '2022-11-16 21:34:39', '0.00'),
(1105, 276, 127, 1, '11.50', 6, NULL, '14:05', NULL, 6, 0, 296, '2022-11-16 21:34:39', '0.00'),
(1106, 276, 130, 1, '13.00', 6, NULL, '14:01', NULL, 9, 0, 296, '2022-11-16 21:34:39', '0.00');
INSERT INTO `toma_pedido` (`id`, `id_pedido`, `id_producto`, `cantidad`, `precio`, `estado`, `nota`, `kpi`, `observaciones`, `item`, `timbre`, `id_facturacion`, `fecha_registro`, `descuento`) VALUES
(1107, 277, 198, 2, '11.00', 6, NULL, '15:51', NULL, 1, 0, 298, '2022-11-16 21:52:03', '0.00'),
(1108, 277, 200, 1, '13.00', 6, NULL, '16:02', NULL, 3, 0, 298, '2022-11-16 21:52:03', '0.00'),
(1109, 277, 243, 1, '9.00', 6, NULL, '02:50', NULL, 1, 0, 298, '2022-11-16 21:52:03', '0.00'),
(1110, 277, 118, 2, '10.00', 6, NULL, '26:32', NULL, 28, 0, 298, '2022-11-16 21:52:03', '0.00'),
(1111, 278, 199, 1, '11.00', 6, NULL, '00:50', NULL, 2, 0, 291, '2022-11-16 21:54:16', '0.00'),
(1112, 278, 256, 1, '1.00', 6, NULL, '00:42', NULL, 2, 0, 291, '2022-11-16 21:54:16', '0.00'),
(1113, 279, 99, 2, '9.50', 6, NULL, '09:49', NULL, 9, 0, 297, '2022-11-16 22:08:43', '0.00'),
(1114, 279, 208, 1, '9.50', 4, NULL, NULL, NULL, 11, 0, NULL, '2022-11-16 22:20:06', '0.00'),
(1115, 280, 99, 2, '9.50', 6, NULL, '14:03', NULL, 9, 0, 299, '2022-11-16 22:29:06', '0.00'),
(1116, 280, 206, 1, '7.50', 6, NULL, '14:24', NULL, 9, 0, 299, '2022-11-16 22:31:22', '0.00'),
(1117, 281, 198, 2, '11.00', 6, NULL, '37:51', NULL, 1, 0, 301, '2022-11-17 16:58:23', '0.00'),
(1118, 281, 99, 2, '9.50', 6, NULL, '12:26', NULL, 9, 0, 301, '2022-11-17 16:58:23', '0.00'),
(1119, 282, 237, 3, '6.00', 6, NULL, '11:16', NULL, 1, 0, 300, '2022-11-17 17:36:16', '0.00'),
(1120, 282, 127, 1, '11.50', 6, NULL, '08:15', 'anulado', 6, 0, 300, '2022-11-17 17:36:16', '0.00'),
(1121, 282, 132, 2, '14.00', 6, NULL, '08:17', NULL, 11, 0, 300, '2022-11-17 17:36:16', '0.00'),
(1122, 283, 126, 2, '13.00', 6, NULL, '03:43', NULL, 5, 0, 303, '2022-11-17 17:51:48', '0.00'),
(1123, 282, 134, 1, '14.00', 6, NULL, '19:47', NULL, 13, 0, 300, '2022-11-17 17:53:49', '0.00'),
(1124, 282, 253, 1, '5.00', 6, NULL, '24:55', NULL, 9, 0, 300, '2022-11-17 17:56:28', '0.00'),
(1125, 281, 99, 2, '9.50', 6, NULL, '08:26', NULL, 9, 0, 301, '2022-11-17 18:00:33', '0.00'),
(1126, 284, 228, 1, '30.00', 6, NULL, '07:13', NULL, 31, 0, 304, '2022-11-17 18:07:06', '0.00'),
(1127, 284, 250, 1, '7.00', 6, NULL, '07:12', NULL, 1, 0, 304, '2022-11-17 18:07:06', '0.00'),
(1128, 284, 228, 1, '30.00', 6, NULL, '22:06', NULL, 31, 0, 304, '2022-11-17 18:28:33', '0.00'),
(1129, 284, 250, 1, '7.00', 6, NULL, '22:00', NULL, 1, 0, 304, '2022-11-17 18:28:33', '0.00'),
(1130, 285, 198, 2, '11.00', 6, NULL, '41:03', NULL, 1, 0, 307, '2022-11-17 18:32:53', '0.00'),
(1131, 285, 250, 2, '7.00', 6, NULL, '41:07', NULL, 1, 0, 307, '2022-11-17 18:32:53', '0.00'),
(1132, 286, 209, 1, '10.00', 6, NULL, '33:01', NULL, 12, 0, 302, '2022-11-17 18:41:03', '0.00'),
(1133, 286, 226, 2, '20.50', 6, NULL, '33:02', NULL, 29, 0, 302, '2022-11-17 18:41:03', '0.00'),
(1134, 286, 99, 3, '9.50', 6, NULL, '09:16', NULL, 9, 0, 302, '2022-11-17 18:41:03', '0.00'),
(1135, 286, 141, 1, '7.50', 6, NULL, '09:20', NULL, 6, 0, 302, '2022-11-17 18:41:03', '0.00'),
(1136, 287, 116, 1, '8.50', 6, NULL, '43:51', NULL, 26, 0, 306, '2022-11-17 19:04:15', '0.00'),
(1137, 287, 126, 1, '13.00', 6, NULL, '05:54', NULL, 5, 0, 306, '2022-11-17 19:04:15', '0.00'),
(1138, 288, 198, 1, '11.00', 6, NULL, '02:19', NULL, 1, 0, 310, '2022-11-17 19:12:16', '0.00'),
(1139, 288, 201, 1, '16.00', 6, NULL, '02:20', NULL, 4, 0, 310, '2022-11-17 19:12:16', '0.00'),
(1140, 288, 127, 2, '11.50', 6, NULL, '06:37', NULL, 6, 0, 310, '2022-11-17 19:12:16', '0.00'),
(1141, 289, 206, 3, '7.50', 6, NULL, '09:10', NULL, 9, 0, 305, '2022-11-17 19:16:26', '0.00'),
(1142, 289, 116, 3, '8.50', 6, NULL, '04:02', NULL, 26, 0, 305, '2022-11-17 19:16:26', '0.00'),
(1143, 285, 250, 2, '7.00', 6, NULL, '52:46', NULL, 1, 0, 307, '2022-11-17 19:19:06', '0.00'),
(1144, 288, 216, 1, '8.00', 6, NULL, '13:24', NULL, 19, 0, 310, '2022-11-17 19:22:18', '0.00'),
(1145, 288, 217, 1, '11.00', 6, NULL, '13:25', NULL, 20, 0, 310, '2022-11-17 19:22:18', '0.00'),
(1146, 288, 139, 1, '7.50', 6, NULL, '21:38', NULL, 4, 0, 310, '2022-11-17 19:22:18', '0.00'),
(1147, 290, 198, 1, '11.00', 6, NULL, '04:43', NULL, 1, 0, 317, '2022-11-17 19:28:21', '0.00'),
(1148, 290, 159, 2, '13.00', 6, NULL, '05:40', NULL, 9, 0, 317, '2022-11-17 19:28:21', '0.00'),
(1149, 184, 198, 1, '11.00', 6, NULL, '00:18', NULL, 1, 0, 309, '2022-11-17 19:28:55', '0.00'),
(1150, 184, 245, 1, '17.00', 6, NULL, '00:18', NULL, 3, 0, 309, '2022-11-17 19:28:55', '0.00'),
(1151, 184, 95, 1, '7.50', 6, NULL, '01:10', NULL, 5, 0, 309, '2022-11-17 19:28:55', '0.00'),
(1152, 184, 134, 1, '14.00', 6, NULL, '05:00', 'sin chantilly', 13, 0, 309, '2022-11-17 19:28:55', '0.00'),
(1153, 291, 198, 1, '11.00', 6, NULL, '03:37', NULL, 1, 0, 316, '2022-11-17 19:34:27', '0.00'),
(1154, 291, 209, 1, '10.00', 6, NULL, '03:38', NULL, 12, 0, 316, '2022-11-17 19:34:27', '0.00'),
(1155, 291, 228, 1, '30.00', 6, NULL, '03:40', NULL, 31, 0, 316, '2022-11-17 19:34:27', '0.00'),
(1156, 291, 99, 1, '9.50', 6, NULL, '11:00', NULL, 9, 0, 316, '2022-11-17 19:34:27', '0.00'),
(1157, 291, 103, 1, '12.00', 6, NULL, '13:37', NULL, 13, 0, 316, '2022-11-17 19:34:27', '0.00'),
(1158, 291, 262, 1, '3.00', 6, NULL, '11:02', NULL, 3, 0, 316, '2022-11-17 19:34:27', '0.00'),
(1159, 292, 207, 1, '9.00', 6, NULL, '00:42', NULL, 10, 0, 319, '2022-11-17 19:37:29', '0.00'),
(1160, 292, 209, 1, '10.00', 6, NULL, '00:43', NULL, 12, 0, 319, '2022-11-17 19:37:29', '0.00'),
(1161, 292, 99, 1, '9.50', 6, NULL, '18:14', NULL, 9, 0, 319, '2022-11-17 19:37:29', '0.00'),
(1162, 292, 123, 1, '13.00', 6, NULL, '18:16', '\npoco chantilly', 2, 0, 319, '2022-11-17 19:37:29', '0.00'),
(1163, 293, 237, 1, '6.00', 6, NULL, '02:24', NULL, 1, 0, 312, '2022-11-17 19:41:15', '0.00'),
(1164, 293, 201, 1, '16.00', 6, NULL, '02:24', NULL, 4, 0, 312, '2022-11-17 19:41:15', '0.00'),
(1165, 293, 139, 1, '7.50', 6, NULL, '14:20', NULL, 4, 0, 312, '2022-11-17 19:41:15', '0.00'),
(1166, 293, 261, 1, '3.00', 6, NULL, '14:22', NULL, 2, 0, 312, '2022-11-17 19:41:15', '0.00'),
(1167, 171, 199, 1, '11.00', 6, NULL, '50:09', NULL, 2, 0, 313, '2022-11-17 19:43:16', '0.00'),
(1168, 171, 95, 1, '7.50', 6, NULL, '51:03', NULL, 5, 0, 313, '2022-11-17 19:43:16', '0.00'),
(1169, 171, 99, 1, '9.50', 6, NULL, '51:05', NULL, 9, 0, 313, '2022-11-17 19:43:16', '0.00'),
(1170, 291, 262, 1, '3.00', 6, NULL, '22:33', NULL, 3, 0, 316, '2022-11-17 19:48:38', '0.00'),
(1171, 294, 250, 2, '7.00', 6, NULL, '04:07', NULL, 1, 0, 308, '2022-11-17 19:56:32', '0.00'),
(1172, 295, 208, 1, '9.50', 6, NULL, '12:35', NULL, 11, 0, 314, '2022-11-17 19:58:31', '0.00'),
(1173, 295, 250, 1, '7.00', 6, NULL, '12:33', NULL, 1, 0, 314, '2022-11-17 19:58:31', '0.00'),
(1174, 295, 260, 1, '3.00', 6, NULL, '09:46', NULL, 1, 0, 314, '2022-11-17 19:58:31', '0.00'),
(1175, 296, 209, 1, '10.00', 6, NULL, '07:02', NULL, 12, 0, 311, '2022-11-17 20:05:52', '0.00'),
(1176, 296, 99, 1, '9.50', 6, NULL, '03:37', NULL, 9, 0, 311, '2022-11-17 20:05:52', '0.00'),
(1177, 292, 198, 1, '11.00', 6, NULL, '35:33', NULL, 1, 0, 319, '2022-11-17 20:12:29', '0.00'),
(1178, 292, 200, 1, '13.00', 6, NULL, '35:34', NULL, 3, 0, 319, '2022-11-17 20:12:29', '0.00'),
(1179, 297, 95, 2, '7.50', 6, NULL, '16:53', NULL, 5, 0, 320, '2022-11-17 20:21:27', '0.00'),
(1180, 297, 139, 1, '7.50', 6, NULL, '16:54', NULL, 4, 0, 320, '2022-11-17 20:21:27', '0.00'),
(1181, 298, 209, 3, '10.00', 6, NULL, '00:43', NULL, 12, 0, 315, '2022-11-17 20:22:21', '0.00'),
(1182, 298, 122, 1, '12.00', 6, NULL, '15:55', 'poco chantilly\n', 1, 0, 315, '2022-11-17 20:22:21', '0.00'),
(1183, 298, 129, 2, '13.00', 6, NULL, '16:04', 'jugo sin leche', 8, 0, 315, '2022-11-17 20:22:21', '0.00'),
(1184, 291, 179, 1, '11.00', 6, NULL, '03:45', NULL, 17, 0, 316, '2022-11-17 20:30:43', '0.00'),
(1185, 291, 163, 1, '13.00', 6, NULL, '03:48', NULL, 13, 0, 316, '2022-11-17 20:32:18', '0.00'),
(1186, 298, 209, 1, '10.00', 6, NULL, '18:04', NULL, 12, 0, 315, '2022-11-17 20:38:44', '0.00'),
(1187, 299, 199, 1, '11.00', 6, NULL, '00:19', NULL, 2, 0, 322, '2022-11-17 20:41:08', '0.00'),
(1188, 299, 209, 4, '10.00', 6, NULL, '00:21', NULL, 12, 0, 322, '2022-11-17 20:41:08', '0.00'),
(1189, 299, 99, 1, '9.50', 6, NULL, '01:35', NULL, 9, 0, 322, '2022-11-17 20:41:08', '0.00'),
(1190, 299, 174, 4, '8.00', 6, NULL, '01:37', NULL, 12, 0, 322, '2022-11-17 20:41:08', '0.00'),
(1191, 300, 198, 3, '11.00', 6, NULL, '04:25', NULL, 1, 0, 318, '2022-11-17 20:49:11', '0.00'),
(1192, 300, 118, 3, '10.00', 6, NULL, '05:51', NULL, 28, 0, 318, '2022-11-17 20:49:11', '0.00'),
(1193, 299, 174, 2, '8.00', 6, NULL, '19:16', NULL, 12, 0, 322, '2022-11-17 20:56:27', '0.00'),
(1194, 297, 242, 1, '9.00', 6, NULL, '47:28', NULL, 5, 0, 320, '2022-11-17 21:04:54', '0.00'),
(1195, 297, 198, 1, '11.00', 6, NULL, '47:30', NULL, 1, 0, 320, '2022-11-17 21:04:54', '0.00'),
(1196, 301, 253, 1, '5.00', 6, NULL, '00:05', NULL, 9, 0, 321, '2022-11-17 21:08:50', '0.00'),
(1197, 301, 206, 2, '7.50', 6, NULL, '00:07', NULL, 9, 0, 321, '2022-11-17 21:08:50', '0.00'),
(1198, 301, 95, 1, '7.50', 6, NULL, '11:30', NULL, 5, 0, 321, '2022-11-17 21:08:50', '0.00'),
(1199, 301, 118, 1, '10.00', 6, NULL, '11:32', NULL, 28, 0, 321, '2022-11-17 21:08:50', '0.00'),
(1200, 301, 127, 1, '11.50', 6, NULL, '11:31', NULL, 6, 0, 321, '2022-11-17 21:08:50', '0.00'),
(1201, 299, 99, 1, '9.50', 6, NULL, '49:10', NULL, 9, 0, 322, '2022-11-17 21:12:14', '0.00'),
(1202, 299, 173, 6, '7.00', 6, NULL, '49:12', NULL, 11, 0, 322, '2022-11-17 21:13:04', '0.00'),
(1203, 302, 253, 3, '5.00', 6, NULL, '20:20', NULL, 9, 0, 323, '2022-11-17 21:20:36', '0.00'),
(1204, 302, 238, 1, '15.00', 6, NULL, '20:15', NULL, 2, 0, 323, '2022-11-17 21:20:36', '0.00'),
(1205, 302, 228, 1, '30.00', 6, NULL, '20:12', NULL, 31, 0, 323, '2022-11-17 21:20:36', '0.00'),
(1206, 302, 99, 1, '9.50', 6, NULL, '09:46', NULL, 9, 0, 323, '2022-11-17 21:20:36', '0.00'),
(1207, 302, 118, 3, '10.00', 6, NULL, '09:47', NULL, 28, 0, 323, '2022-11-17 21:20:36', '0.00'),
(1208, 302, 139, 1, '7.50', 6, NULL, '09:47', NULL, 4, 0, 323, '2022-11-17 21:20:36', '0.00'),
(1209, 302, 201, 1, '16.00', 6, NULL, '20:13', NULL, 4, 0, 323, '2022-11-17 21:35:08', '0.00'),
(1210, 302, 245, 1, '17.00', 6, NULL, '20:14', NULL, 3, 0, 323, '2022-11-17 21:38:00', '0.00'),
(1211, 303, 201, 1, '16.00', 6, NULL, '00:06', NULL, 4, 0, 324, '2022-11-17 21:53:51', '0.00'),
(1212, 303, 214, 1, '15.00', 6, NULL, '00:05', NULL, 17, 0, 324, '2022-11-17 21:53:51', '0.00'),
(1213, 303, 140, 2, '7.50', 6, NULL, '02:48', NULL, 5, 0, 324, '2022-11-17 21:53:51', '0.00'),
(1214, 304, 228, 3, '30.00', 6, NULL, '01:35', NULL, 31, 0, 325, '2022-11-17 22:00:52', '0.00'),
(1215, 304, 245, 1, '17.00', 6, NULL, '01:33', NULL, 3, 0, 325, '2022-11-17 22:00:52', '0.00'),
(1216, 304, 99, 2, '9.50', 6, NULL, '21:53', NULL, 9, 0, 325, '2022-11-17 22:00:52', '0.00'),
(1217, 304, 126, 1, '13.00', 6, NULL, '21:55', NULL, 5, 0, 325, '2022-11-17 22:00:52', '0.00'),
(1218, 305, 206, 2, '7.50', 6, NULL, '01:04', NULL, 9, 0, 327, '2022-11-17 22:01:19', '0.00'),
(1219, 305, 209, 1, '10.00', 6, NULL, '01:05', NULL, 12, 0, 327, '2022-11-17 22:01:19', '0.00'),
(1220, 305, 118, 2, '10.00', 6, NULL, '18:16', NULL, 28, 0, 327, '2022-11-17 22:01:19', '0.00'),
(1221, 305, 198, 1, '11.00', 6, NULL, '03:49', NULL, 1, 0, 327, '2022-11-17 22:04:08', '0.00'),
(1222, 302, 139, 1, '7.50', 6, NULL, '46:23', NULL, 4, 0, 323, '2022-11-17 22:04:15', '0.00'),
(1223, 306, 242, 1, '9.00', 6, NULL, '00:08', NULL, 5, 0, 326, '2022-11-17 22:05:03', '0.00'),
(1224, 306, 199, 1, '11.00', 6, NULL, '00:08', NULL, 2, 0, 326, '2022-11-17 22:05:03', '0.00'),
(1225, 306, 226, 1, '20.50', 6, NULL, '00:10', NULL, 29, 0, 326, '2022-11-17 22:05:03', '0.00'),
(1226, 306, 250, 1, '7.00', 6, NULL, '00:10', NULL, 1, 0, 326, '2022-11-17 22:05:03', '0.00'),
(1227, 306, 135, 1, '17.00', 6, NULL, '14:34', NULL, 14, 0, 326, '2022-11-17 22:05:03', '0.00'),
(1228, 304, 99, 2, '9.50', 6, NULL, '21:56', NULL, 9, 0, 325, '2022-11-17 22:19:23', '0.00'),
(1229, 304, 253, 1, '5.00', 6, NULL, '24:08', NULL, 9, 0, 325, '2022-11-17 22:20:42', '0.00'),
(1230, 304, 122, 1, '12.00', 6, NULL, '21:57', NULL, 1, 0, 325, '2022-11-17 22:20:42', '0.00'),
(1231, 307, 130, 1, '13.00', 6, NULL, '11:31', NULL, 9, 0, 328, '2022-11-18 16:50:52', '0.00'),
(1232, 307, 257, 1, '1.00', 6, NULL, '11:37', NULL, 1, 0, 328, '2022-11-18 16:50:52', '0.00'),
(1233, 308, 242, 1, '9.00', 6, NULL, '20:44', NULL, 5, 0, 329, '2022-11-18 17:27:45', '0.00'),
(1234, 308, 208, 2, '9.50', 6, NULL, '20:43', NULL, 11, 0, 329, '2022-11-18 17:27:45', '0.00'),
(1235, 308, 250, 1, '7.00', 6, NULL, '24:16', NULL, 1, 0, 329, '2022-11-18 17:27:45', '0.00'),
(1236, 309, 198, 1, '11.00', 6, NULL, '13:01', NULL, 1, 0, 330, '2022-11-18 17:28:48', '0.00'),
(1237, 309, 118, 2, '10.00', 6, NULL, '00:37', NULL, 28, 0, 330, '2022-11-18 17:28:48', '0.00'),
(1238, 310, 238, 4, '15.00', 6, NULL, '26:40', NULL, 2, 0, 331, '2022-11-18 17:29:58', '0.00'),
(1239, 311, 199, 1, '11.00', 6, NULL, '15:39', NULL, 2, 0, 335, '2022-11-18 17:46:48', '0.00'),
(1240, 311, 163, 1, '13.00', 6, NULL, '11:05', NULL, 13, 0, 335, '2022-11-18 17:46:48', '0.00'),
(1241, 311, 125, 1, '18.00', 6, NULL, '11:06', 'con chantilly', 4, 0, 335, '2022-11-18 17:46:48', '0.00'),
(1242, 310, 127, 1, '11.50', 6, NULL, '31:16', NULL, 6, 0, 331, '2022-11-18 17:53:26', '0.00'),
(1243, 308, 256, 1, '1.00', 6, NULL, '34:39', NULL, 2, 0, 329, '2022-11-18 18:02:06', '0.00'),
(1244, 310, 147, 1, '3.00', 6, NULL, '34:42', NULL, 2, 0, 331, '2022-11-18 18:04:24', '0.00'),
(1245, 310, 147, 1, '3.00', 6, NULL, '34:42', NULL, 2, 0, 331, '2022-11-18 18:04:26', '0.00'),
(1246, 312, 133, 1, '14.00', 6, NULL, '15:09', NULL, 12, 0, 333, '2022-11-18 18:19:32', '0.00'),
(1247, 312, 134, 1, '14.00', 6, NULL, '15:10', NULL, 13, 0, 333, '2022-11-18 18:19:32', '0.00'),
(1248, 313, 201, 1, '16.00', 6, NULL, '17:25', NULL, 4, 0, 332, '2022-11-18 18:26:07', '0.00'),
(1249, 313, 207, 1, '9.00', 6, NULL, '06:39', NULL, 10, 0, 332, '2022-11-18 18:26:07', '0.00'),
(1250, 313, 99, 3, '9.50', 6, NULL, '08:40', NULL, 9, 0, 332, '2022-11-18 18:26:07', '0.00'),
(1251, 314, 228, 1, '30.00', 6, NULL, '11:40', NULL, 31, 0, 334, '2022-11-18 18:31:57', '0.00'),
(1252, 314, 255, 1, '1.50', 6, NULL, '11:40', NULL, 1, 0, 334, '2022-11-18 18:31:57', '0.00'),
(1253, 314, 144, 1, '9.00', 6, NULL, '02:46', NULL, 9, 0, 334, '2022-11-18 18:31:57', '0.00'),
(1254, 314, 257, 1, '1.00', 6, NULL, '02:49', NULL, 1, 0, 334, '2022-11-18 18:32:43', '0.00'),
(1255, 315, 198, 2, '11.00', 6, NULL, '20:08', NULL, 1, 0, 336, '2022-11-18 18:47:39', '0.00'),
(1256, 315, 201, 1, '16.00', 6, NULL, '20:09', NULL, 4, 0, 336, '2022-11-18 18:47:39', '0.00'),
(1257, 315, 99, 1, '9.50', 6, NULL, '03:47', NULL, 9, 0, 336, '2022-11-18 18:47:39', '0.00'),
(1258, 315, 118, 1, '10.00', 6, NULL, '03:48', NULL, 28, 0, 336, '2022-11-18 18:47:39', '0.00'),
(1259, 316, 198, 4, '11.00', 6, NULL, '20:03', NULL, 1, 0, 337, '2022-11-18 18:53:55', '0.00'),
(1260, 316, 98, 1, '7.50', 6, NULL, '14:54', NULL, 8, 0, 337, '2022-11-18 18:53:55', '0.00'),
(1261, 316, 99, 1, '9.50', 6, NULL, '14:51', NULL, 9, 0, 337, '2022-11-18 18:53:55', '0.00'),
(1262, 316, 117, 2, '8.00', 6, NULL, '14:50', NULL, 27, 0, 337, '2022-11-18 18:53:55', '0.00'),
(1263, 317, 245, 1, '17.00', 6, NULL, '11:35', NULL, 3, 0, 338, '2022-11-18 18:56:17', '0.00'),
(1264, 317, 164, 1, '15.00', 6, NULL, '12:37', NULL, 14, 0, 338, '2022-11-18 18:56:17', '0.00'),
(1265, 317, 139, 1, '7.50', 6, NULL, '12:40', NULL, 4, 0, 338, '2022-11-18 18:56:17', '0.00'),
(1266, 184, 139, 1, '7.50', 6, NULL, '40:29', NULL, 4, 0, 357, '2022-11-18 19:10:14', '0.00'),
(1267, 318, 198, 1, '11.00', 6, NULL, '11:16', NULL, 1, 0, 342, '2022-11-18 19:14:45', '0.00'),
(1268, 318, 199, 1, '11.00', 6, NULL, '11:13', NULL, 2, 0, 342, '2022-11-18 19:14:45', '0.00'),
(1269, 318, 206, 1, '7.50', 6, NULL, '11:10', NULL, 9, 0, 342, '2022-11-18 19:14:45', '0.00'),
(1270, 318, 95, 2, '7.50', 6, NULL, '03:56', NULL, 5, 0, 342, '2022-11-18 19:14:45', '0.00'),
(1271, 318, 116, 1, '8.50', 6, NULL, '03:58', NULL, 26, 0, 342, '2022-11-18 19:14:45', '0.00'),
(1272, 319, 198, 2, '11.00', 6, NULL, '07:27', NULL, 1, 0, 339, '2022-11-18 19:15:03', '0.00'),
(1273, 319, 256, 2, '1.00', 6, NULL, '07:34', NULL, 2, 0, 339, '2022-11-18 19:15:03', '0.00'),
(1274, 184, 128, 1, '15.00', 6, NULL, '53:57', NULL, 7, 0, 357, '2022-11-18 19:18:45', '0.00'),
(1275, 184, 139, 1, '7.50', 6, NULL, '53:58', NULL, 4, 0, 357, '2022-11-18 19:18:45', '0.00'),
(1276, 320, 198, 1, '11.00', 6, NULL, '11:16', NULL, 1, 0, 344, '2022-11-18 19:44:38', '0.00'),
(1277, 320, 200, 1, '13.00', 6, NULL, '11:17', NULL, 3, 0, 344, '2022-11-18 19:44:38', '0.00'),
(1278, 320, 208, 1, '9.50', 6, NULL, '58:34', NULL, 11, 0, 344, '2022-11-18 19:44:38', '0.00'),
(1279, 320, 217, 1, '11.00', 6, NULL, '23:12', NULL, 20, 0, 344, '2022-11-18 19:44:38', '0.00'),
(1280, 320, 255, 1, '1.50', 6, NULL, '58:28', NULL, 1, 0, 344, '2022-11-18 19:44:38', '0.00'),
(1281, 320, 147, 1, '3.00', 6, NULL, '20:05', NULL, 2, 0, 344, '2022-11-18 19:44:38', '0.00'),
(1282, 320, 122, 2, '12.00', 6, NULL, '20:06', NULL, 1, 0, 344, '2022-11-18 19:44:38', '0.00'),
(1283, 320, 139, 1, '7.50', 6, NULL, '20:08', NULL, 4, 0, 344, '2022-11-18 19:44:38', '0.00'),
(1284, 320, 238, 1, '15.00', 6, NULL, '58:40', NULL, 2, 0, 344, '2022-11-18 19:47:36', '0.00'),
(1285, 321, 206, 1, '7.50', 6, NULL, '08:40', NULL, 9, 0, 341, '2022-11-18 19:58:04', '0.00'),
(1286, 321, 99, 1, '9.50', 6, NULL, '06:50', NULL, 9, 0, 341, '2022-11-18 19:58:04', '0.00'),
(1287, 321, 118, 2, '10.00', 6, NULL, '06:54', NULL, 28, 0, 341, '2022-11-18 19:58:04', '0.00'),
(1288, 321, 249, 1, '7.00', 6, NULL, '06:51', NULL, 4, 0, 341, '2022-11-18 19:58:04', '0.00'),
(1289, 322, 209, 2, '10.00', 6, NULL, '12:47', NULL, 12, 0, 347, '2022-11-18 19:59:59', '0.00'),
(1290, 322, 225, 1, '18.00', 6, NULL, '12:49', NULL, 28, 0, 347, '2022-11-18 19:59:59', '0.00'),
(1291, 322, 99, 3, '9.50', 6, NULL, '08:02', NULL, 9, 0, 347, '2022-11-18 19:59:59', '0.00'),
(1292, 323, 228, 1, '30.00', 6, NULL, '24:21', NULL, 31, 0, 346, '2022-11-18 20:04:20', '0.00'),
(1293, 323, 260, 2, '3.00', 6, NULL, '03:47', '', 1, 0, 346, '2022-11-18 20:04:20', '0.00'),
(1294, 324, 198, 2, '11.00', 6, NULL, '13:57', NULL, 1, 0, 340, '2022-11-18 20:04:48', '0.00'),
(1295, 324, 99, 2, '9.50', 6, NULL, '08:44', NULL, 9, 0, 340, '2022-11-18 20:04:48', '0.00'),
(1296, 323, 215, 1, '8.00', 6, NULL, '24:16', NULL, 18, 0, 346, '2022-11-18 20:06:00', '0.00'),
(1297, 320, 217, 1, '11.00', 6, NULL, '42:32', NULL, 20, 0, 344, '2022-11-18 20:06:45', '0.00'),
(1298, 321, 214, 1, '15.00', 6, NULL, '25:35', NULL, 17, 0, 341, '2022-11-18 20:10:37', '0.00'),
(1299, 325, 206, 1, '7.50', 6, NULL, '12:34', NULL, 9, 0, 350, '2022-11-18 20:16:13', '0.00'),
(1300, 325, 209, 5, '10.00', 6, NULL, '12:38', NULL, 12, 0, 350, '2022-11-18 20:16:13', '0.00'),
(1301, 325, 99, 5, '9.50', 6, NULL, '10:08', NULL, 9, 0, 350, '2022-11-18 20:16:13', '0.00'),
(1302, 325, 261, 1, '3.00', 6, NULL, '10:07', NULL, 2, 0, 350, '2022-11-18 20:16:13', '0.00'),
(1303, 326, 204, 1, '5.00', 6, NULL, '13:44', NULL, 7, 0, 343, '2022-11-18 20:18:23', '0.00'),
(1304, 326, 205, 1, '7.00', 6, NULL, '13:47', NULL, 8, 0, 343, '2022-11-18 20:18:23', '0.00'),
(1305, 326, 99, 1, '9.50', 6, NULL, '07:59', NULL, 9, 0, 343, '2022-11-18 20:18:23', '0.00'),
(1306, 326, 129, 1, '13.00', 6, NULL, '10:28', 'SIN CHANTILLY', 8, 0, 343, '2022-11-18 20:18:23', '0.00'),
(1307, 321, 206, 1, '7.50', 6, NULL, '30:40', NULL, 9, 0, 341, '2022-11-18 20:20:59', '0.00'),
(1308, 327, 215, 2, '8.00', 6, NULL, '19:42', NULL, 18, 0, 345, '2022-11-18 20:26:26', '0.00'),
(1309, 327, 216, 1, '8.00', 6, NULL, '19:45', NULL, 19, 0, 345, '2022-11-18 20:26:26', '0.00'),
(1310, 327, 95, 1, '7.50', 6, NULL, '09:57', NULL, 5, 0, 345, '2022-11-18 20:26:26', '0.00'),
(1311, 327, 190, 1, '19.50', 6, NULL, '11:22', NULL, 30, 0, 345, '2022-11-18 20:26:26', '0.00'),
(1312, 184, 228, 2, '30.00', 6, NULL, '22:15', NULL, 31, 0, 357, '2022-11-18 20:37:09', '0.00'),
(1313, 325, 206, 1, '7.50', 6, NULL, '27:56', NULL, 9, 0, 350, '2022-11-18 20:37:58', '0.00'),
(1314, 184, 139, 1, '7.50', 6, NULL, '11:23', NULL, 4, 0, 357, '2022-11-18 20:38:20', '0.00'),
(1315, 328, 253, 2, '5.00', 6, NULL, '09:29', NULL, 9, 0, 348, '2022-11-18 20:40:24', '0.00'),
(1316, 328, 99, 2, '9.50', 6, NULL, '03:49', NULL, 9, 0, 348, '2022-11-18 20:40:24', '0.00'),
(1317, 329, 198, 2, '11.00', 6, NULL, '08:49', NULL, 1, 0, 349, '2022-11-18 20:45:06', '0.00'),
(1318, 329, 99, 1, '9.50', 6, NULL, '05:24', NULL, 9, 0, 349, '2022-11-18 20:45:06', '0.00'),
(1319, 329, 141, 1, '7.50', 6, NULL, '05:26', NULL, 6, 0, 349, '2022-11-18 20:45:06', '0.00'),
(1320, 328, 253, 2, '5.00', 6, NULL, '09:31', NULL, 9, 0, 348, '2022-11-18 20:48:13', '0.00'),
(1321, 0, 95, 3, '7.50', 4, NULL, NULL, NULL, 5, 1, NULL, '2022-11-18 20:54:00', '0.00'),
(1322, 0, 258, 3, '1.00', 4, NULL, NULL, NULL, 2, 1, NULL, '2022-11-18 20:54:00', '0.00'),
(1323, 184, 261, 1, '3.00', 6, NULL, '38:30', NULL, 2, 0, 357, '2022-11-18 20:58:11', '0.00'),
(1324, 184, 228, 1, '30.00', 6, NULL, '42:25', NULL, 31, 0, 357, '2022-11-18 21:07:14', '0.00'),
(1325, 184, 261, 1, '3.00', 6, NULL, '45:16', NULL, 2, 0, 357, '2022-11-18 21:07:14', '0.00'),
(1326, 330, 222, 1, '9.50', 6, NULL, '21:24', NULL, 25, 0, 355, '2022-11-18 21:07:49', '0.00'),
(1327, 330, 262, 2, '3.00', 6, NULL, '10:14', NULL, 3, 0, 355, '2022-11-18 21:07:49', '0.00'),
(1328, 331, 199, 1, '11.00', 6, NULL, '11:15', NULL, 2, 0, 352, '2022-11-18 21:10:50', '0.00'),
(1329, 331, 209, 3, '10.00', 6, NULL, '11:11', NULL, 12, 0, 352, '2022-11-18 21:10:50', '0.00'),
(1330, 331, 250, 2, '7.00', 6, NULL, '11:13', NULL, 1, 0, 352, '2022-11-18 21:10:50', '0.00'),
(1331, 331, 261, 1, '3.00', 6, NULL, '07:13', NULL, 2, 0, 352, '2022-11-18 21:10:50', '0.00'),
(1332, 332, 253, 1, '5.00', 6, NULL, '09:05', NULL, 9, 0, 353, '2022-11-18 21:13:05', '0.00'),
(1333, 332, 118, 2, '10.00', 6, NULL, '05:02', NULL, 28, 0, 353, '2022-11-18 21:13:05', '0.00'),
(1334, 333, 253, 2, '5.00', 6, NULL, '10:20', NULL, 9, 0, 356, '2022-11-18 21:28:15', '0.00'),
(1335, 333, 209, 4, '10.00', 6, NULL, '10:22', NULL, 12, 0, 356, '2022-11-18 21:28:15', '0.00'),
(1336, 333, 139, 1, '7.50', 6, NULL, '03:10', NULL, 4, 0, 356, '2022-11-18 21:28:15', '0.00'),
(1337, 333, 141, 5, '7.50', 6, NULL, '03:14', NULL, 6, 0, 356, '2022-11-18 21:28:15', '0.00'),
(1338, 334, 127, 1, '11.50', 6, NULL, '07:27', '', 6, 0, 351, '2022-11-18 21:31:24', '0.00'),
(1339, 334, 257, 1, '1.00', 6, NULL, '07:28', NULL, 1, 0, 351, '2022-11-18 21:31:24', '0.00'),
(1340, 335, 253, 1, '5.00', 6, NULL, '17:07', NULL, 9, 0, 354, '2022-11-18 21:36:52', '0.00'),
(1341, 335, 254, 2, '5.00', 6, NULL, '17:06', NULL, 10, 0, 354, '2022-11-18 21:36:52', '0.00'),
(1342, 335, 237, 2, '6.00', 6, NULL, '11:23', NULL, 1, 0, 354, '2022-11-18 21:36:52', '0.00'),
(1343, 335, 206, 1, '7.50', 6, NULL, '17:09', NULL, 9, 0, 354, '2022-11-18 21:36:52', '0.00'),
(1344, 335, 115, 1, '6.50', 6, NULL, '15:44', NULL, 25, 0, 354, '2022-11-18 21:37:21', '0.00'),
(1345, 335, 117, 3, '8.00', 6, NULL, '15:42', '', 27, 0, 354, '2022-11-18 21:37:21', '0.00'),
(1346, 333, 253, 2, '5.00', 6, NULL, '25:56', NULL, 9, 0, 356, '2022-11-18 21:40:24', '0.00'),
(1347, 336, 253, 1, '5.00', 6, NULL, '17:37', NULL, 9, 0, 361, '2022-11-18 21:41:17', '0.00'),
(1348, 336, 99, 1, '9.50', 6, NULL, '11:20', NULL, 9, 0, 361, '2022-11-18 21:41:17', '0.00'),
(1349, 336, 209, 1, '10.00', 6, NULL, '09:44', NULL, 12, 0, 361, '2022-11-18 21:42:55', '0.00'),
(1350, 336, 95, 1, '7.50', 6, NULL, '11:14', NULL, 5, 0, 361, '2022-11-18 21:42:55', '0.00'),
(1351, 335, 98, 2, '7.50', 6, NULL, '15:42', NULL, 8, 0, 354, '2022-11-18 21:44:10', '0.00'),
(1352, 337, 198, 2, '11.00', 6, NULL, '14:41', NULL, 1, 0, 358, '2022-11-18 21:53:43', '0.00'),
(1353, 337, 201, 1, '16.00', 6, NULL, '14:42', NULL, 4, 0, 358, '2022-11-18 21:53:43', '0.00'),
(1354, 337, 120, 4, '7.00', 6, NULL, '14:46', NULL, 2, 0, 358, '2022-11-18 21:53:43', '0.00'),
(1355, 333, 139, 2, '7.50', 6, NULL, '30:09', NULL, 4, 0, 356, '2022-11-18 21:54:03', '0.00'),
(1356, 338, 206, 1, '7.50', 6, NULL, '06:09', NULL, 9, 0, 360, '2022-11-18 22:17:17', '0.00'),
(1357, 338, 95, 1, '7.50', 6, NULL, '06:36', NULL, 5, 0, 360, '2022-11-18 22:17:17', '0.00'),
(1358, 338, 99, 1, '9.50', 6, NULL, '06:32', NULL, 9, 0, 360, '2022-11-18 22:17:17', '0.00'),
(1359, 338, 122, 1, '12.00', 6, NULL, '06:34', NULL, 1, 0, 360, '2022-11-18 22:17:38', '0.00'),
(1360, 336, 209, 1, '10.00', 6, NULL, '42:13', NULL, 12, 0, 361, '2022-11-18 22:18:53', '0.00'),
(1361, 338, 253, 1, '5.00', 6, NULL, '10:53', NULL, 9, 0, 360, '2022-11-18 22:23:19', '0.00'),
(1362, 339, 99, 1, '9.50', 6, NULL, '05:17', NULL, 9, 0, 362, '2022-11-18 22:28:06', '0.00'),
(1363, 339, 127, 1, '11.50', 6, NULL, '05:23', NULL, 6, 0, 362, '2022-11-18 22:28:06', '0.00'),
(1364, 339, 129, 1, '13.00', 6, NULL, '05:19', NULL, 8, 0, 362, '2022-11-18 22:28:06', '0.00'),
(1365, 340, 127, 2, '11.50', 6, NULL, '04:40', NULL, 6, 0, 359, '2022-11-18 22:28:39', '0.00'),
(1366, 340, 257, 2, '1.00', 6, NULL, '04:52', NULL, 1, 0, 359, '2022-11-18 22:28:39', '0.00'),
(1367, 339, 249, 1, '7.00', 6, NULL, '05:21', NULL, 4, 0, 362, '2022-11-18 22:29:50', '0.00'),
(1368, 342, 119, 1, '5.00', 6, NULL, '00:17', NULL, 1, 0, 363, '2022-11-25 10:02:28', '0.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turnos`
--

CREATE TABLE `turnos` (
  `id` int NOT NULL,
  `descripcion` varchar(50) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `inicio` time NOT NULL,
  `fin` time NOT NULL,
  `estado` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `turnos`
--

INSERT INTO `turnos` (`id`, `descripcion`, `inicio`, `fin`, `estado`) VALUES
(1, 'TODO', '00:00:00', '23:59:59', 1),
(2, 'MAÑANA', '00:00:00', '15:59:59', 1),
(3, 'TARDE', '16:00:00', '23:59:59', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicaciones`
--

CREATE TABLE `ubicaciones` (
  `id` int NOT NULL,
  `descripcion` varchar(50) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `estado` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `ubicaciones`
--

INSERT INTO `ubicaciones` (`id`, `descripcion`, `estado`) VALUES
(1, 'TODO', 1),
(2, 'SALON', 1),
(3, 'TERRAZA', 1),
(4, 'DELIVERY', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int NOT NULL,
  `id_empleado` int NOT NULL,
  `estado` int NOT NULL DEFAULT '0',
  `clave` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `id_empleado`, `estado`, `clave`) VALUES
(1, 1, 1, '202cb962ac59075b964b07152d234b70'),
(2, 2, 1, '202cb962ac59075b964b07152d234b70'),
(3, 3, 1, '202cb962ac59075b964b07152d234b70'),
(4, 4, 1, '202cb962ac59075b964b07152d234b70'),
(5, 5, 1, '202cb962ac59075b964b07152d234b70'),
(6, 6, 1, '202cb962ac59075b964b07152d234b70'),
(7, 7, 1, '202cb962ac59075b964b07152d234b70'),
(8, 8, 1, '202cb962ac59075b964b07152d234b70'),
(9, 9, 1, '202cb962ac59075b964b07152d234b70'),
(10, 10, 1, '202cb962ac59075b964b07152d234b70');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `utensilio`
--

CREATE TABLE `utensilio` (
  `id` int NOT NULL,
  `nombre` varchar(75) NOT NULL,
  `estado` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `utensilio`
--

INSERT INTO `utensilio` (`id`, `nombre`, `estado`) VALUES
(1, 'Lechuga', 0),
(2, 'Tomate', 0),
(3, 'Palta', 0),
(4, 'Cebolla', 0),
(5, 'Mayonesa', 0),
(6, 'Ketchup', 0),
(7, 'Mostaza', 0),
(8, 'Aji', 0),
(9, 'Majote', 0),
(10, 'Bituca', 0),
(11, 'Yucas', 0),
(12, 'Recacha', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `utensilio_producto`
--

CREATE TABLE `utensilio_producto` (
  `id` int NOT NULL,
  `id_producto` int NOT NULL,
  `id_utensilio` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `utensilio_producto`
--

INSERT INTO `utensilio_producto` (`id`, `id_producto`, `id_utensilio`) VALUES
(19, 1, 4),
(21, 1, 7),
(22, 1, 3),
(23, 1, 2),
(24, 10, 9),
(25, 10, 11),
(26, 10, 12),
(27, 10, 10),
(28, 11, 9),
(29, 11, 10),
(30, 11, 11),
(31, 11, 12);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dni` (`dni`);

--
-- Indices de la tabla `estado_proceso`
--
ALTER TABLE `estado_proceso`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `facturacion`
--
ALTER TABLE `facturacion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `medios_pago`
--
ALTER TABLE `medios_pago`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `mesa`
--
ALTER TABLE `mesa`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `promocion_bonus`
--
ALTER TABLE `promocion_bonus`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `promocion_puntos`
--
ALTER TABLE `promocion_puntos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `serie_comprobante`
--
ALTER TABLE `serie_comprobante`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_comprobante`
--
ALTER TABLE `tipo_comprobante`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_empleado`
--
ALTER TABLE `tipo_empleado`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_servicio`
--
ALTER TABLE `tipo_servicio`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `toma_pedido`
--
ALTER TABLE `toma_pedido`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `turnos`
--
ALTER TABLE `turnos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ubicaciones`
--
ALTER TABLE `ubicaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `utensilio`
--
ALTER TABLE `utensilio`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `utensilio_producto`
--
ALTER TABLE `utensilio_producto`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `estado_proceso`
--
ALTER TABLE `estado_proceso`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `facturacion`
--
ALTER TABLE `facturacion`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=364;

--
-- AUTO_INCREMENT de la tabla `log`
--
ALTER TABLE `log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2593;

--
-- AUTO_INCREMENT de la tabla `medios_pago`
--
ALTER TABLE `medios_pago`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `mesa`
--
ALTER TABLE `mesa`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=343;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=264;

--
-- AUTO_INCREMENT de la tabla `promocion_bonus`
--
ALTER TABLE `promocion_bonus`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `promocion_puntos`
--
ALTER TABLE `promocion_puntos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `serie_comprobante`
--
ALTER TABLE `serie_comprobante`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tipo_empleado`
--
ALTER TABLE `tipo_empleado`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tipo_servicio`
--
ALTER TABLE `tipo_servicio`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `toma_pedido`
--
ALTER TABLE `toma_pedido`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1369;

--
-- AUTO_INCREMENT de la tabla `turnos`
--
ALTER TABLE `turnos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ubicaciones`
--
ALTER TABLE `ubicaciones`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `utensilio`
--
ALTER TABLE `utensilio`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `utensilio_producto`
--
ALTER TABLE `utensilio_producto`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
