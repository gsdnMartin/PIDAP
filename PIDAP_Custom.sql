PGDMP         1            
    {            pidap #   14.9 (Ubuntu 14.9-0ubuntu0.22.04.1) #   14.9 (Ubuntu 14.9-0ubuntu0.22.04.1) *    `           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            a           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            b           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            c           1262    16385    pidap    DATABASE     Z   CREATE DATABASE pidap WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';
    DROP DATABASE pidap;
                postgres    false            d           0    0    DATABASE pidap    ACL     %   GRANT ALL ON DATABASE pidap TO mots;
                   postgres    false    3427            �            1255    16386    valida_cp()    FUNCTION     �   CREATE FUNCTION public.valida_cp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
  IF NEW.cp IS NULL OR NEW.cp <= 20000 OR NEW.cp >= 99998 THEN
    RAISE EXCEPTION 'Código postal incorrecto';
  END IF;
  RETURN NEW;
END;
$$;
 "   DROP FUNCTION public.valida_cp();
       public          mots    false            �            1255    16387    valida_valor()    FUNCTION     �   CREATE FUNCTION public.valida_valor() RETURNS trigger
    LANGUAGE plpgsql
    AS $$begin
  if NEW.valor IS NULL OR NEW.valor < 1 THEN
	raise exception 'Ingresa cantidad valida';
    RETURN FALSE; 
  END IF;

  RETURN NEW;
END;$$;
 %   DROP FUNCTION public.valida_valor();
       public          mots    false            �            1259    16388    comercio_exterior    TABLE       CREATE TABLE public.comercio_exterior (
    id_ce integer NOT NULL,
    id_distribuidora integer NOT NULL,
    tipo character varying NOT NULL,
    unidad character varying NOT NULL,
    periodo date NOT NULL,
    movimiento character varying NOT NULL,
    valor numeric NOT NULL
);
 %   DROP TABLE public.comercio_exterior;
       public         heap    mots    false            �            1259    16630    distribuidora    TABLE     �   CREATE TABLE public.distribuidora (
    id_distribuidora integer NOT NULL,
    id_estado integer NOT NULL,
    id_pozo integer NOT NULL,
    ubicacion character varying,
    cp integer NOT NULL
);
 !   DROP TABLE public.distribuidora;
       public         heap    postgres    false            �            1259    16398    estado    TABLE     �   CREATE TABLE public.estado (
    id_estado integer NOT NULL,
    nombre character varying NOT NULL,
    min_cp integer NOT NULL,
    max_cp integer NOT NULL
);
    DROP TABLE public.estado;
       public         heap    mots    false            �            1259    16403    pozo    TABLE     m   CREATE TABLE public.pozo (
    id_pozo integer NOT NULL,
    id_estado integer,
    periodo date NOT NULL
);
    DROP TABLE public.pozo;
       public         heap    mots    false            �            1259    16406 
   produccion    TABLE     �   CREATE TABLE public.produccion (
    id_produccion integer NOT NULL,
    id_pozo integer,
    tipo character varying NOT NULL,
    unidad character varying(5) NOT NULL,
    periodo date NOT NULL,
    valor numeric
);
    DROP TABLE public.produccion;
       public         heap    mots    false            �            1259    16411 	   productos    TABLE     �   CREATE TABLE public.productos (
    id_productos integer NOT NULL,
    id_distribuidora integer NOT NULL,
    magna boolean NOT NULL,
    premium boolean NOT NULL,
    diesel boolean NOT NULL,
    dme boolean NOT NULL
);
    DROP TABLE public.productos;
       public         heap    mots    false            �            1259    16414    quejas    TABLE     �   CREATE TABLE public.quejas (
    id_queja integer NOT NULL,
    id_distribuidora integer NOT NULL,
    estado character varying NOT NULL,
    anio integer NOT NULL
);
    DROP TABLE public.quejas;
       public         heap    mots    false            �            1259    16419    ventas_internas    TABLE     �   CREATE TABLE public.ventas_internas (
    id_vi integer NOT NULL,
    id_distribuidora integer NOT NULL,
    tipo character varying NOT NULL,
    unidad character varying(5) NOT NULL,
    periodo date NOT NULL,
    valor numeric
);
 #   DROP TABLE public.ventas_internas;
       public         heap    mots    false            �            1259    16677    vista_distribuidora_estado    VIEW     '  CREATE VIEW public.vista_distribuidora_estado AS
 SELECT p.id_estado AS id_distribuidora,
    e.nombre AS nombre_estado,
    count(*) AS cantidad
   FROM (public.distribuidora p
     JOIN public.estado e ON ((p.id_estado = e.id_estado)))
  GROUP BY p.id_estado, e.nombre
 HAVING (count(*) > 0);
 -   DROP VIEW public.vista_distribuidora_estado;
       public          postgres    false    210    218    210            �            1259    16428    vista_pozo_estado    VIEW       CREATE VIEW public.vista_pozo_estado AS
 SELECT p.id_estado,
    e.nombre AS nombre_estado,
    count(*) AS cantidad
   FROM (public.pozo p
     JOIN public.estado e ON ((p.id_estado = e.id_estado)))
  GROUP BY p.id_estado, e.nombre
 HAVING (count(*) > 3);
 $   DROP VIEW public.vista_pozo_estado;
       public          mots    false    211    210    210            �            1259    16432    vista_produccion_anual    VIEW       CREATE VIEW public.vista_produccion_anual AS
 SELECT EXTRACT(year FROM produccion.periodo) AS anio,
    sum(produccion.valor) AS produccion_total
   FROM public.produccion
  GROUP BY (EXTRACT(year FROM produccion.periodo))
  ORDER BY (EXTRACT(year FROM produccion.periodo));
 )   DROP VIEW public.vista_produccion_anual;
       public          mots    false    212    212            V          0    16388    comercio_exterior 
   TABLE DATA           n   COPY public.comercio_exterior (id_ce, id_distribuidora, tipo, unidad, periodo, movimiento, valor) FROM stdin;
    public          mots    false    209   @5       ]          0    16630    distribuidora 
   TABLE DATA           \   COPY public.distribuidora (id_distribuidora, id_estado, id_pozo, ubicacion, cp) FROM stdin;
    public          postgres    false    218   ]5       W          0    16398    estado 
   TABLE DATA           C   COPY public.estado (id_estado, nombre, min_cp, max_cp) FROM stdin;
    public          mots    false    210   .�       X          0    16403    pozo 
   TABLE DATA           ;   COPY public.pozo (id_pozo, id_estado, periodo) FROM stdin;
    public          mots    false    211   .�       Y          0    16406 
   produccion 
   TABLE DATA           Z   COPY public.produccion (id_produccion, id_pozo, tipo, unidad, periodo, valor) FROM stdin;
    public          mots    false    212   ��       Z          0    16411 	   productos 
   TABLE DATA           `   COPY public.productos (id_productos, id_distribuidora, magna, premium, diesel, dme) FROM stdin;
    public          mots    false    213   ��       [          0    16414    quejas 
   TABLE DATA           J   COPY public.quejas (id_queja, id_distribuidora, estado, anio) FROM stdin;
    public          mots    false    214   �       \          0    16419    ventas_internas 
   TABLE DATA           `   COPY public.ventas_internas (id_vi, id_distribuidora, tipo, unidad, periodo, valor) FROM stdin;
    public          mots    false    215   <�       �           2606    16437 (   comercio_exterior comercio_exterior_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.comercio_exterior
    ADD CONSTRAINT comercio_exterior_pkey PRIMARY KEY (id_ce);
 R   ALTER TABLE ONLY public.comercio_exterior DROP CONSTRAINT comercio_exterior_pkey;
       public            mots    false    209            �           2606    16636     distribuidora distribuidora_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.distribuidora
    ADD CONSTRAINT distribuidora_pkey PRIMARY KEY (id_distribuidora);
 J   ALTER TABLE ONLY public.distribuidora DROP CONSTRAINT distribuidora_pkey;
       public            postgres    false    218            �           2606    16441    estado estado_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (id_estado);
 <   ALTER TABLE ONLY public.estado DROP CONSTRAINT estado_pkey;
       public            mots    false    210            �           2606    16443    pozo pozo_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.pozo
    ADD CONSTRAINT pozo_pkey PRIMARY KEY (id_pozo);
 8   ALTER TABLE ONLY public.pozo DROP CONSTRAINT pozo_pkey;
       public            mots    false    211            �           2606    16445    produccion produccion_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.produccion
    ADD CONSTRAINT produccion_pkey PRIMARY KEY (id_produccion);
 D   ALTER TABLE ONLY public.produccion DROP CONSTRAINT produccion_pkey;
       public            mots    false    212            �           2606    16447    productos productos_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id_productos);
 B   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_pkey;
       public            mots    false    213            �           2606    16449    quejas quejas_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.quejas
    ADD CONSTRAINT quejas_pkey PRIMARY KEY (id_queja);
 <   ALTER TABLE ONLY public.quejas DROP CONSTRAINT quejas_pkey;
       public            mots    false    214            �           2606    16451 $   ventas_internas ventas_internas_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.ventas_internas
    ADD CONSTRAINT ventas_internas_pkey PRIMARY KEY (id_vi);
 N   ALTER TABLE ONLY public.ventas_internas DROP CONSTRAINT ventas_internas_pkey;
       public            mots    false    215            �           2620    16453    ventas_internas valida_valor    TRIGGER     �   CREATE TRIGGER valida_valor BEFORE INSERT OR UPDATE ON public.ventas_internas FOR EACH ROW EXECUTE FUNCTION public.valida_valor();
 5   DROP TRIGGER valida_valor ON public.ventas_internas;
       public          mots    false    215    220            �           2606    16637 *   distribuidora distribuidora_id_estado_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.distribuidora
    ADD CONSTRAINT distribuidora_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado);
 T   ALTER TABLE ONLY public.distribuidora DROP CONSTRAINT distribuidora_id_estado_fkey;
       public          postgres    false    218    210    3251            �           2606    16642 (   distribuidora distribuidora_id_pozo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.distribuidora
    ADD CONSTRAINT distribuidora_id_pozo_fkey FOREIGN KEY (id_pozo) REFERENCES public.pozo(id_pozo);
 R   ALTER TABLE ONLY public.distribuidora DROP CONSTRAINT distribuidora_id_pozo_fkey;
       public          postgres    false    218    3253    211            �           2606    16672    comercio_exterior fk_ce    FK CONSTRAINT     �   ALTER TABLE ONLY public.comercio_exterior
    ADD CONSTRAINT fk_ce FOREIGN KEY (id_distribuidora) REFERENCES public.distribuidora(id_distribuidora) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.comercio_exterior DROP CONSTRAINT fk_ce;
       public          mots    false    3263    209    218            �           2606    16667    produccion fk_produccion    FK CONSTRAINT     �   ALTER TABLE ONLY public.produccion
    ADD CONSTRAINT fk_produccion FOREIGN KEY (id_pozo) REFERENCES public.pozo(id_pozo) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.produccion DROP CONSTRAINT fk_produccion;
       public          mots    false    3253    212    211            �           2606    16662    quejas fk_quejas    FK CONSTRAINT     �   ALTER TABLE ONLY public.quejas
    ADD CONSTRAINT fk_quejas FOREIGN KEY (id_distribuidora) REFERENCES public.distribuidora(id_distribuidora) ON DELETE CASCADE;
 :   ALTER TABLE ONLY public.quejas DROP CONSTRAINT fk_quejas;
       public          mots    false    3263    218    214            �           2606    16657    ventas_internas fk_vi    FK CONSTRAINT     �   ALTER TABLE ONLY public.ventas_internas
    ADD CONSTRAINT fk_vi FOREIGN KEY (id_distribuidora) REFERENCES public.distribuidora(id_distribuidora) ON DELETE CASCADE;
 ?   ALTER TABLE ONLY public.ventas_internas DROP CONSTRAINT fk_vi;
       public          mots    false    3263    218    215            �           2606    16469    pozo pozo_id_estado_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pozo
    ADD CONSTRAINT pozo_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado);
 B   ALTER TABLE ONLY public.pozo DROP CONSTRAINT pozo_id_estado_fkey;
       public          mots    false    3251    211    210            V      x������ � �      ]      x�e�]��,�3z�k0��?�=�w����$�����SU	cٲl��?+�����W�Y�k����V�߼�n������9&.���헎����Y����g߸�/>�K�����Y��˭����n�������q��[��z�۩�����/��������o��'q���9�z�Ŋ���V�'h���[�חz��;��M������wG}���ߡ-�������ϟ��5>a���x��c��p}���}�f�����}�;��lغx����������X����`��r������;!���k����������nx�{7ݾ����[O�����ww�_�9~��?qo����3����u�=�Ӯ��w����%}b�
�;lS_qoy�-��U�����h`��|���=Ә��/_Ck�w�E6�[�����{�-�z��o�O{�����k����[r������h/w���`���~?��_�>���O����������so�ml�o�ft�ϭkv�t,ܮ�����w�����Lo�_����4����z���}%~b?C�v��E���>Cr��]I���Z�������7	{~`emܶ}�`����y�~�F�ߧ|���;��!_��{��S��_��o⚯��ܞ�:�{X�g~����g�ݶ����,>pG�7��`��7oؾ��������-6��Ҿ���Mp���S�oy�X�������>2>ÈET�~ol���g+F�Ӥ|�u�ty�O?M�{�ka�};�p� �R�������o~k���}���sd̃mY����1�)�Ow��d嫚qa������k���S��S�^�[8{����W��!,Z�cx����<!�G��~�ݫN�S]�ǡ}�Kmx�ƛ��S�x�CC__t_��x�	�6���En�j��}�,���f���.x[���}�>49�|����/_����Q��S94��?x�r�z���jԎ���zW�:vj�x���Q|�v.=��<ͼjp���v�@�?��}?��Fsz|%�������W��G[]o���Sq�ב�1NǊ�h���}��/��U���� .�^�?Ǭ��Z�U���t�w�'?������#�G��a52���#t��w-F��Ї9�g�p#��S|�qC~��us��!3f�ϐz�����%~�|����t��ak���|Gp�G#��o�i��|-�en����}d���u�G��~˦_wW�D߯7Z�����)���o�{�u:y�a��a��tl��N -��UpO�.�ȸ��yca�7���_�Bm��+�Ƀ�EwBﮓ��G5�#1���}h��ĕy�O���y�h�q������ɥy�����o|>�Y�힫w��y�՚�S�6+�滻���u=�;���X������"_n���	O�y6<rl<�;��曺kt�˫�(���M�`��."��:��m�M���13���_O��*]���0b��ko|�4���L�Ne�G�pU�n��ٱ�8�W��}�Z����Gp᭱Ƹ����rh?C��!n�Y�m�U���b0�Cx��;�W�aJ�����1���A�c��Z�ݝ} ��)�k���؝�|��*Kڧ���װ,��q�W/���Ь�%����u�s �_�[?�u������?�u1�i��y]]wﯣX�6̅4~;w�\z��>|��G�]��DՊ���}�Sk`��Z���f�u����V��鱱e��#��ѵv��������NX��5��^��ԡ�G�o�ˉ$��&�!�f�#؇�U]u����h�i��r^���w�o *�����)��}��}��Kw޽�N�����w�T�ۻ^P�ߤ}Ѯ�u�~�WW _�[�^��4���3�+L<4�G�>�������+�Z��s��zZ[�;2�H�Ȧ���P��w�����y_L��ϗE�}�]��rj��e�ӝ�c5}��yq�1����ew�k���^fY<h*'���ut���;.%Yٱ���o�~����D�� ����!eA ֒^J���.�[��d�.��>+����8����2��m��mŮ��0tOU]e�����r�w�:~���k��e�l�a÷Tl�ý3��!.:�v�ͯ�r�p��p��pE�Gz�,gmL��-L�g��^sP�-�����j�7^k�zkwnw+R�d�`����i2R���VQ���}��1p�H}�}7��v�uǤߓ�8��_��j]O�7�|�eu7A]Hc]�c�!8FXz& ��F}w��ݰ��X���?C����<�/N��BF@��i�6��pd��s��E���u� ��&�6��h�v:�8�sk����j�=�MH�H�[p0�5c3�������L^uӹc'�@��>��{��=Ǘi���w5˝�p�(~�*?� ��ډ�	hcQ�l.&p�V��r��]���	��5F�kZ�V���\��-��u���c�Fj��_�t������x�m<Қp]8��k���E׾�Rۥ'���!��ׁm�A(�\�ހ�����`��N�����D��B�	 �(�� ��3k"�׈e\�q ~r�L�mw���Z���SS�ƣ"��g���������=��ޘ80`�7�5�K��ad©��1?ς��m��VQ4�h�ׅ�w�ӛAt�.:ĴL;#�F�6��f��vr�V�9��k��ߡ�uɫ&s*�8_�n�G� ��Ls��irdy[ӏ�k(�K^�1�wQp��/�V�s�����*7��  l��y�'���|�A|�#���U}W4����L�Nc�S���CWLr$zk\Rw8��wE��WT[�&���u�SL�O����b��e�~�}C~j_h�[]����w�H�5;����U�'�_ppo]��>�4��Y��8���!�v����;�[�_�/�(u��{����9��{�?x�)�w�>�*��UE}qQ����]�w����xƦ��L��� �������G{z4��9����p�%|�q��<��?E�;6_�aa�p�q����l�p�ۜ׷��oz$#g䳘�+�Ur� X��>�# :��}'::Ȟ�1���۷����� ��R��0�|ON�(����.��q��Q/:�=��4��ӑ",�����M��ɣ]H����]5>����9>.P,?�ѿ}-�B��1�r�8����u���9t:�ږ�ܮ�'p�b�Fa9���WѤ� >P]��ے���ӌd%>(��O�똼S���]���4eX1BW��֚�0�bbd�ɛ���l���w�߹�����{8�iݎ��qdZd2P��phi���x��6<�zm^R6����!����!߬�Y,�������wN��F�L��<���@c<���T&^��\� _4	>�m7�������m	BN�-E'��.Wxgz)iOSU���G�cB��"^�ނg�<����!���Ȇ���imBM��Gk>�1ku�eN[�p���消�\�ϰ��u!R���V����j����/�ME������e*�VX��3ri�!x�������}�ePp�����<�$�J�9��.��}�is��#�W��&r�F^��_�Є�&J�x�D�&�a[����ű����~�*'�xM?��x�q�V���n���2݅�)&f -�)���xӦ[F�I�&l����_�-7]�r�P;�#�O��*�2a�`��	Yw����*�)�8
>H��N{����n���}k��)\{�{�DΣt� ��]kY��6����"��=��h�2㝸ֽ�HmR�Ʀ���L�SS�\�sW�,9���G��f��6��i�?`���@�xW����*�3Z���X���2���i
B1j`g�W�|n�%憩4����XL�����,�b�L����*�e6!Y<�br[�ͦ����eX[|W�3��	k�d=<O���/`P��wk��m����/|���|��O`�����m�d�Ѝ#�j�ѻw)�/���}T�*��=i/h.F    �"%�X���Y�� ì�E*X��:3O�	T��}`�<�=p��v��<2}�n$����XAjM��M��I�2ҌN9�y���Jx�l�͊�(��:��ȡ���ن嘆�F��� ���k]82�so҃��,ȷ!��*��6|^�qGv CA'7$w��_4��wȮ�/���P`�Z��r� \�������?����|��w�\d�����k���ۄ�DrpM:�6�	�j�;�)��e.6���� ܯr+�0��x=Ð��{�j%m�� �R�l�+���m���W�(���A+?�	#�2�AgLa.em'�: W�������|�X�""��#n��ˎd�=�,��5��{\�#D��ݞ���=/�a�2d��;�蚻�|��� �9A��t�%(�m���r��-�I�ef�P3�[�f]�A$�
2�����遯�{�����tl�r��V�6z�ā�nrM�D�w���mb�^'ż1�-��6�&`+�,���͔��uw�ܡ�)CTx���Ejp �0o�����	?fp_�r]��#Ff�z��i%�8�g#V�ߨ@%�`i(��ᕾ_ʋ��2v'c�ɤ��	mk����,���S3�&t(�
���3�)rU>�u'�	|2.��G�wi��`W*^����vA nN�uE�~���;p2pax�,�oD����
�0?~�e��7�Ȃ+���+���n�ņ^�tx<�%��Iw��t�a_��T�J+<	cj�E�����W���he�8X�]	�`��kk��#��s�7sT�����e P�{\PL�VRI�ô���@'ؖm{�X������5G1�{�/�0���n:b��Y~u���9F�q%l�]����A̒��' Ȋ*�w}��	��^ͅ��qr$
mq���/��B@��gf4g@)�NH�ᡈ�w�{���1L�A犸wLǝ�y[k�Ik5���!�>GJ�HM�ؚ<���;� g�Ħ�i����M9<�c��MOL�^����i�أ��/��߷K�Y���
zO�,�F��u~��:��v!�h�@ȡ�Xd�� '*�Z�gu~��Gb�(5���y�첒��S�n��D,��[)R�����D�0H�|HRҁd��7�����"~Y�1#��H��ǳO�*�0�!�S�4$ߔ�&a�����̬�i�qN��.�wDI�;�S"y �y01��x�㾭Xv+�QB�up�{S�ɸ�t�`�E9�.B9�1Z�Ԑ8�58�P���V��"�5��i�S?/����}�(���S�:$�l6�Y��� +���`u�H��'\�c�c�q����p��Mx���ઈ�	sg�>��i��x��E�#XiB��9:��~�/�A� ��y�X��p�3��4��άHi\5����ppr�� De�8ñ��i� �j|!��x��"���>`qS���ɒ��_m��="݇j��`]����|\s%�\'��p��aG���\�y���)ZT���H`���cs�[�`t�ye>���=_�G�j���=�V`�e{��� 1_�7X�������Ֆ�v�:w=�N�9,��� g��`(� ��S.l��8��UN���4�F��lC`1�p�L?�k��4V<7�g6E��w�$���$�G�����q�zd?��ʈ$�g�Z�L��L�8b3C5�OWm�"Q���X�#(���)��7أ�`6���9ZÁ,C]�u�I ��?�S�Hra?:�b��=8���8p�7����s���No�+9g�E��t�p�b	��]^���$��}/wV|��VI�A�uL���z&w7bAߡk��ө�}Kp�FB���3�����9W�^�C5X�q)�Q����u4qq��ވ�'�@��z3�Dp-;�~<��# *�a<��	�N���Y��)���vr�ULJƫfZ@���E,N@���x�(��U/ư�U��%�P�!W�~j= N����x��Ed$:��������+�����3��.�B>�������p����=���d\T矄g�*,�D�ke�`Џ2����d$�A��[��S�#;'�֑R)�À���F���^�����m��`�s�_X� �̬��	��wa�#����U�k�̔)���ۑ� ���8�����U���n��z�)�@<�q��(����Ş>�p�,�.�oȱ ERІ2)��J���4?_k�(y@����gX�?W@�I���Y��N~��ɍ��V��抹f�͙C�X�����Т6c���b� �=��אM��	����'�/$a�"��`�,f|�4y�մ�f{�Dfӟ�����C/K�o���ǥ�J�et��X�r/d2�/7�m�L�;� =A�Um��ĉO"e�t�l$��8
�6���;I�=\��V�)3R V���ǚ�6�/��B�Wz)I5��� 0���+Àk3D�p�<���?.�½��9D��i��=+K��Kc�&�I��ة����� %���Q�X:�'Ur�Z7|�𫼺�u����>�X�L���9RFq�!�@S<SV�O¡��$;�)3�A<ƊP�^���>6R�(����K�ًMx�
�N
��6����q|�TZי[��I�3��ƈ������߄C͓�WC�];����e�]ˁ-ʟs�.Jki�D��U��P�V�s�5 ����P�`���]C
A����5��DGr���D��u�9η��q��-�~}o��<(���`�۞W�>ltk�p���l��ufShRS���b��?.\��	*^'�9p���<pi��b��� �9�^Y��Ğ�Q�p8����g���~�?�����r�� p����\��o��/�P�j�U5�?,>x�����=ҙ3���ȜF_����w��ߤŔ��b��zn?v�p�*;��_��	<�Dz��O��@�AHUɸ��I842[��Ke��z�{����[ �j���P�9�3�/��>|i5�������t�@J�����3~d�m���uM7�򂵈J5̂.*�ڡ���΍�ZŁ9��%O�pi�/b�<y��D�X\��[�����_�$?����дz�.�`��y����aPU�����
�J)�Ad8	�8Ŋum��.�G͢~+H�<"|�j����Ad��B��x.���=Rb�cY���� �'S m$T�1ԥZ2�ii ��&@m���vb��V}�s�)
ǀ���I��%r��i�1� �r�ZJ&4փ�F�ǝ��N0�W� �VX���n���� 4t������C�=!�k�=9f5:$�b/�6B��H��1˪&/ö��l��9��='X�c__�_���E���J+�xx�*�4dƇ�AX�������zP�O��rn�C��<��:C�AH!��E)��}R/M#�%b���7��^��	��#U�]�d_6�~����o �ָ<bb�1�0��Yq(�>��+���Eu\�qYm]!>�]�:;�É7{I	7�޿İu�>�!78)��Ι�6�Q"�_G�{�(4����rr�1���MQ��H�/]�/ֶ��Z
׮I9
�-��`��E���i!�A�H�zbc�t?��9����!^X��R�u6��E\EWcBﴌ? TE�en�U�D�KNqS�Sf�f�b�q>�`�|�4��;�,i�LL�W�[������k�1]��vmj�����VF6���3uu��
���T�0�[T54�Z9����ⓞN�|4S�.��y���Ύ������{R�t����}�8�L��
�UR1�u�'��W����<�{�P���B��2y��m#x�r.鄡��P�Ka\�[
��q��EP$Hh�@壒�ڢ�����݂��3�r�YΉ��a�t�&�<���y��k t*3G��;f��,����IIF�UB��;?!?S�#�+(�9l�TZp��a�a@�Jo����gާ�3�w:��w    ��͔V�d�D9��t��X<*$2Q#���pZO�c�P4kp7 gƁ5'���h2�U�ᛆܘ8/���K��"��`7i3A��0�� tP
��T�t�6����n@��� ��`�j��K�#@�	���<�DUT;�Ae̤2�����į:bR!��=H��vx�L�'�G���i��!��&����<Z��W��O�' mG�C���uyD7�@��C���)�#��ƵR��!i��G�q���o�T󺼒}u*�t���{K�z����MM���a������fT
~��h��Q<wK���!$���>+��O�U�)�h�~�q�w(���SN���6����_��oY}0j�?g���=�X�Ib�o�+œ�
-N����9z����P��lK|��_��;_)�c���������#'��Yw��x�L�ʨ�3I�SGo���w6��.����a �/���g�&�j;2m�&�/d���RRa;x��yŞV�`�r�T��D�X�dS���hZ��+�|������X�8��:I9�i[Ę����� t�):��U�`��$ҙ�U�wfM��dr�E��:?����A��c���,�h�:,,�[�>�u��)3�Q��b7W+��+���D�^�,d�Y%U�-���r��.	.bjf���[����uS�l8�U%�ę}OG��M�:�]h�E~�E�̈R���Cb8	�2[���<Fё���E��>�
m"#�r��:V+����bz��R�L�e��Y���6�kZ��~:>���ՙ9���
|-��|"�1l@������@�Gؓ�C��(j�耮1Ma�(J��pt�X� &1~�.�ӂ� �
o`�)2&eT:�ubU��+z)��E�f	��)�pw&Āј�Lv��z������r�{<!�۞���ްI�&+WI}"z2""����K ~swh�4�A/���TmF<R�@�����
Uox3iV��!���x8����TCI�Us�sl�L��� !W�P�J���Uł�t{yx�|�Z�5GIgU��@Z�SNՙ3a������	���|l~�����]S��HU%�:�����y��Љ����`�P#нfe*�n��ȡS����_Qn"�b=gx�B��L�ֲ �O�h5�;�r��t��6�D�޴~�\R�.GR bgbN��$2h�$��O;�P�kA���W�����8|�z	B�p�Kph�oeނ{'�����N�Էt���D�_[.��B��,L�,^���A:4*e�";Wg��P2�	�x#���3=�G��A䲟,�	Ŗ��<��x/���|gyEb�����s�Lq�<fI��Uo�\��mT�9��ނ��}<������G�9�
C�T��e�'_$~��|�9?�F��ۂ��xn`i�'��Xb��L@YF�����BEҖ�wQ�V�
�KP���о�I��ѣQF
C���YC~�%�z-�t�C|��gb����	��xGF���ZQ����zE��������F�?%J�'��A�9�]wұ��?p��&�����8�q���������"o:�<=��#���,`b�;�7���Z�yΫ�6�Τ��g?����)�ZO$��x𜧛�X����|bҞ�����Xt0~ȵ�S�^�����"�{�~G�~q�6c q�c�?����^�{Gf��dW��	u�׳Nb�A]k��lT�#$-fV��"/O"����TڈB4T��o@���H�:�n+Ť�T>�F76����s�H��"�ܞ�����n{w�r�!yM�z�
�(�kOa©�.r�ؐ�3����?*�� t��{�PBK�� �g�8���A�l����k�0`���=Q{Q�R$ܔ]���u�c��^3>.�6P>��(]����gK�5�<C�X,?6+X'%���R�I��W��1��!S`͂�K�M�x�c3i�Jf�����BRQ:*��ėe�b�7�H,�s�@���14,F�����׳u�̙���:��l����o~��t���~Rx�H��O��j��L�7eIߔb-� �6�:A�$�?0q�j1;��)�B�(U�^ݨ%�jzp�� Y��A%U���}l�@�Ƚ~HH��r��T��^$�Ùj�v������H?�i����,V�R0L%hO�{�C�!�+"zP:�:���G���.<� u%xFd^�{"�,��
��`�HlA�f�zZrn�+{��y�C�;��4'����/8p����B�b���Y�P:ZQ�AG�N��'滁=Ѽ�|��YxY��)��Wև��i�%��@趰.�B�,o?�����5�c`0?�^�D����'�F~$�L�~N��mn$��n��뮁�b ��ʤ)�=:���%]X�wq���EG���Ӳs'i,�O��b��_�d�m��S��8f)��Ȍ$�������_j`Ҷ;҆5e�A��w��.c�䨓/q���v:)��,g
za(�0��IǨ�/ �,ڋ�N��_����!�2Iд�h��L��ދ�����:��z)�6������6*�,�,���N�s."ۍ��dZ-	5�3��Qv|P�:@�ޱgF\�򻖪�PG7(��f :���j,�Q5x�(M��� E�Hև�㇚�¤>P�`���
.(�-�d�'�n�h���΀P&��B�E�� Vm���g�Ɵ�!X���D�Kt�C1V�l:����D�r��p'�U���`�b���)��jX\4؋�Q������\}L�Zf}��7���6{�#�Y�$��!\ [2kM,љ�G��?M�Q:!��4�'�C6fYI�e�;� �B5������M��b��)Ws�՟�/�t���������$�ډ�qI��8����yz_�A	@@-h�I.婢�隽+�F�vn�mf.�4~g�.����܊_uW`�tF׃
����"/Xy�g���f%��=�Rr���*�Zll�~K􂀃��L7E�#��
�:�F�{ -�z���D_�t��^j�q�r�1qT�w�l�j���!��4���lc��>IG]��/G'��A*�8$�N ���JKŬT�vg��Ȩ�
��/�T���Qb���Q(���l�ɯz맔z���,�kv�,t/�B�$�z��GR�VKɂ.Z)��/k(J���l����|�y3A�e}�N��4)i��OE�E���$B}���`@=Ub��:� �<s{���,Z�-��J���y!�+�ꒅd��}4�wK�� 6��%�vi5�V��S�V&d����G�_셖%hDF��R�l�u�P����)���� gVU�I���~@�p��4x�����!��K�c������lo�\zk�-����y������o�������Cm�Rc���9 �\�Ρ�gځ!�z:٭�:[��W�ǩ��,�	e����$a�\�+��.�e�Ԣ�n�$�ż�D۴�9��hU!鹠u�'�GPr�_
5R�s����Ze��Sٌ� ۙg���#=I����W��� wuJv"�ۥr6	����IjAI��/���'��V����0g���[�N�&��[���=�W��}��	Z���8t��#��!�	�J��& ������-M�Fi���Z6;4RT8��	4��?�_�C�z��G\�ί��H����Tc�Q�y(��-D��R�t�D��G����_��%t5K'Q��G0�L}�z
����̐�}���5������`([�x$T�̺�5�<���Ɔx����A*�\^�.T���R�l)W�=�
������SH��D���;dJ��sA�ag>�/�� �	��?���L9+4,h������2��׃b�(<���Ma��I5��FU���,
��>6a�މG�:����wn�_�6�������Ie�l�1�����q֘u�� qN����LJ�63�;����j�����F�0�����J����B#a��N�cm?Ihv�+g�Ї ?�(�z��U�^��o�q#��+��&Vb.Tv��E����    H�~�-b8� h�hLE�QQ�e�!��s�Rl�a���މ$����"@.y���-$<� Q�I�G ��rYA\Iuo�����k����@��3�̀X�%����� ���|݈��ݑ��n�z����{���Db����9�䒯�C��ACY���]B/�+X�#ha�¥�3�R2���x]�x�a(Fg�W�;mł��ܕ��9�_b�R�DEn�.أ�}U�:��,�u �&�0���jN>Qd������EU���|���E���2z�l�!�aa���8�S�\*����2�����6�op'���m��7��)�iew�:�OU)FD%�)�4�u`r�L�-�n��Ӭ��X)��LǏ��ԓ{#�"Ҥ1sR�;&�|�<�-5(8�VY*q$S��C��935��p�余�Z�I	B��x�rL���GŲ�`�J��_�1?�biW$��O.K6d�Cc�Z�՛E�w^3��@v��ֲ,=�wge��C�-�$��(��{nMI��I��<��^�׽�G����"$��|h<"ʞr��6q��n}A��,#���f�p�8�g��c�\�a�9h�J��YR�w��<��ʢ�eZ#������2�eS+�UN��_���r��p�y�H����z\)�@פ�����35e`	����cK��$���4}��?-:G���ɤ�\�c�>�ު(�S���:yպ؄Q�8 #�+@�U]�ã�v�J>H�ou��&��>>�l%�ml?���RscO�m�I�lh� ��u�u���AH�Gp�$�B�z1T�t���Oo�C�u��E+m���3l�H��3�*䙒I0c2���9���٢̭�6r����?�EfE���.�K}�%>�`�cy?���)Y�ҏq#�A�$�7-�� n�#a;��~J���`���>nX��6��P�B���w��ӯ��K���q���3?ꙧf�~��F��HY��H�?��d��F��j,�^z�6
�����D"������$�z��Z8h�z�S�30z���Т$����j�?�znn���T�c�#|�~D��9|���+J�vM@Zj�?�:�������h���/����)�H�*!8����A&�26�
�׉��&xP�u9� U�c0�=.��dû����	��ç�7*E�17R"�]��9�ʙ kUA��vr#y��Y[ঈ��]&�"xc��CB�e'�@�w�IĻ���>:�ݼ/"�H�8n�_X���	D�

���Ԙ�h�.0���`����+ ��RʿcﶞB��S�[�~�8�<�[%"-z��m�J}`�3"!{��3��Zi)��{(��S��oR��HN��D����@�!G��l@W8|��㚦��(��V����e-
-vSU�D5�r����Ĕ�2�,�JnI����q�,(�SB^��.gf��#d�K��!f�t0	f�I���r���𢚯�E�җ��2S��M�]s�5V�D�H�ϝ"�%��?7���ة�D5xj#�r�^"�T�k!�����?m�v*NZI�Pi��j�CL*�����sh��LJ�W���G�	gGr4Np�;��R%�e�2�t�*����K�*%�ܕ�9F����H���p��Knj�͚1e�������H��F�R!��0
�1 j�x@o�@f{X M�,`�0I�l�.GL�1s�(59[�D̉<8��d�/�lb�3�uJ�惲T	J"�1�8�uP�+�Z�#v
�@(�UB-�����I�phgKr���n�s�n����N����Y,G��#
m��Ob���ɚ1�Ȋ[�X��D5�"3]��5z�O&i��Ju�R͋�b��XI}v5�e��Eև"0�~͖;b���<IJ~�f���]��;��kYI-�Z��%�D��Q����Nw�Q/��l�0=e��1e27 �~y)�����Y��V��"����a�Xج�T�X}����*h_W<��S~z2WE��X̘���a��8#�rV��c^v��x�5��f0O7���~w�\fϵ�$:�6At��^���AP$�4h{�.mQ4:T� ����ǨJ�d�����YAf[F���Sх��y�A��;�	}�׳��4�$�z�lb���t2��QAL���h�zV����(0��$���t�݇�^.�r1*�����R����5e������T~���,x80�Op�iRmg�Ģ�s⺩���j-���+VPb+b8�>�����!���UbL����Ggrl�X
nFOLypf�&�up�sz#�g���{D�`4�V���ϰ���S�ox��uOky?�
��#^P`�"j ��赎��U﹙���%WJ�����JU�d,>O�of#���߽��=�J6�Am��Ķ2
�IV�J�u��;{j���@�Ee٦�%�Q�F��;|@�����P�qh������I*[ZL�J?�0V��	^Ú�%9�	�]��ہI�Ũ��h<��Iru�!,oc���>(��U�]����6�S�K�u��6��������Q�4�XN���ć�,��b�/V�tV��Ik=oJ���z����_%���t�%m�GX�W�L��.�š�1�P��-��y�V4z�+V.���{��1�Ԥ]��SP��ݠ����f��)���
��v����O��atG������Oԁ����*R��Iv -{ԨC������s 5�9����� r)�r~b�Ĉ��vJH`�U�Pq"��yL���*[q�I��P�r2rL���v�w�F������j�����g��F�:&<j�Eʡۚ��a=�z���]?�/���T4ZYe�y0�:(h@�������N,�ΖJ ��(�ⱃs^\��oUVE�݃o�,�0�(g����|}�(3<D��&����'�1�'���Ǥ)@�u�^��#;B�:��},x�X��25iIOPc��v�~i���y2�&����F��G�K�$��Mnl�#iv�����W��nL�=C�=*�Z���z��'�h��#���FsU�!��]a�^/��@,t;�'��N�	t�EV�C̩͢3.�C����G�;M:h:\���X�_hp8Esm�:T&��@�O�Q�Rj��-���E�I,sy�O��x�����Y1ٟ$Y��?A��j�#xuCnٛ�F���T�*fA|ݡb.-�C[�L3�Kis��������SyX��c#�Y��va5i��~�r�0�5��e��5��3_Q�BK����ܡ�V�'�I�R6�v��?%�M�@��NJu�jɉ�ļ��8/[!v�	V��=c� >?��'Ʀ<�<. ,+H(_Q� ֲ��}��E͔�CJvG��R��G%�(�I���Rxs��p�)��Z��4XWMX�߀,�9!��K��C��sS�Z>�g�}l>xm�ZbR�zoN8�����<�(�-�!�Vٗ+�0��>�bRz$�w�Y;��ǇIQ�#Q�#V�T�B m��NUEjʪ[o?�j(�㣫�x�ƪ�gç��to�̄�|h�m"�H�<�
�������
Uc-A;^�$%��O� �ҔJ��R��E��JM��<{^3o�^��4�PҤ�j�
 �J2�{�`�ewU�8��'C_���h�Kx�6�^$U;6th�=&|Nr��UHgz8�����?� $�o�[Zw]�����d� [p��pM��{��,$'ɃQI�hV7�d�t�rn���`J����.�zz]�
ۀ��a���O��>�*@ŃyϳG���hD�0�Ā��?��*̡I	�!���r��{:�u�t���bt`���;j����T}]l }�9]W�NH{X�yE��1j���Gwg�E=|��l��b�n�$�����=ʝ��&ے�%�o|�2��]��Ku�8ܳc<�t���@gx���������,� X�|97j|���$�o���agHS� Yw�փ��`��8�r4�k�^��Lw9}���i� �
  ~�'q��'�yd�F^t&�^2B����n�k��a�z�x:p {�`������8�[|���:��Q�I�G�d���Q@��b�Qp O��Կ��ش}�!)�GtfK]�<��+\��]?�g��k��?�x����e:+$�&� ��{��1��=�{�5%��w�!��x�!P�?�=�],Gm�2����g�[
<H{	')4�:(�l�4�4�1'0�.K�$�@h� z��/�)�۪+&���=�94�rB���R�&�X�����P�I�d�
�����#�Z "z�a-��&�%�Q�RH��`�1�MJq�jƗ��UW�y�8�+�"j(m���6��1�N�<����� �H��7*����~0tY�ьH�F�iF�՝���ҦQ4�z<���#�m�|"��N=M f��p$��5*w|����]�#��2�����n���R�@r��\k{�.F":<�ֱ�;�yU�*�yzm{�0��A
CoS/4b�����ư���]����C��7z��N����?��)8� ~�O**��G���`9��!����]]LV�Ǌ^�~�*���*K��3�>t~��<Qㄡ��ܻ���RM:�^�e?���f?A5wy_l$l�M�o(C����p��K�1b��-1C���9�B�@H��j�8�q���  )`VS�	?�ٜ�ݘ>�tD��#��:�mD��ɛ�#Z�go:^��pP�h�uz��r]�U��p!7:ܳ�j��p��߽�����O�$��{B�v�])'e�+fƂ�cמ���^�5�Q��WS�`O����F1J���hӫ@�n��W���(��ak:;���д��@�=hV6��G���`a�v�b�"LMi��/(Ǭ+m"H��?E�
�lzP+� ��T)��3��hz�L"òn	z
+���K���}m�1��<#s�%�x�ŁQf�������������Q��إ��yg�Ǿ�T-�8Wa8�4�gf�H�P˙��d"tqhs|K���ec�($�-��(��~3~'�}e�(:�����,��'P�ȗ<����}HGv����v�֫�j*k��ܤ{�ҫS�q#�ص �iO5LY+�AF%>Z�2�Et	ƣ��U�M�q���$ǅ�q��D�`��d�=s]�H���:]��a��~B@�9�}d?�d���G�/?U���d��R����5���ر��*��4P`l�'?�bװh�XJ��{�*��^b�N9�g+�@6�
�u<��ګ�0¸\��#��{�q����Y,��4A 1T<}�+,`�dʥ�q�IF��ɟ�.`ZV];ŸgHT�O2���Q )�4x��\�|]Y7���dng��S8c�l����|�f�� u �g�?T"̖���D��z�����?��q���}R��l-���'�XE��=�����,�U�� ���j�|�=X퇙�]~ÑP)p�m~4>���c0�s3+,�ˍ�T��k�F��^��3�P���Z�/ʮ͜[&���F���&[@G2�v�Og������n�=g�L�,�4�$��F��B\�5��/?
Ta���ZѺs߃J7�[����^	�%��¹F��@"�j��-|W�.�FT��R�A��P���J�>4A��r�̝�ܶ��q��v��,�.�q��^�mw����J(��ߝ��P;[wF�:����[CC6uM�rW���)9�Z'D
��l�`�CC����3��݊	"��U��e��̦%Q)&O��+<F�$	�R���%DXv����ɓc�=��b�l{f���e.�Gyl�n|�t6�d(-7�	��b1��uE�H8��M������]�Q��y�+E6]ۤ�]-I����/X�!i��J,�[�0R~&	��ԁU�=��2]��Y�C-Z���1SZ��U�&vπu4Ryz�|��o���#]�{���y~$m�7�r�ܔ<�ra�5]��
IEK�����PŘ���r>��*O*~ߍ�
�Q�'�·�Ou����^�U����w��i�6a-��3�A�T�e��Zsa�Q����$U����s��>��)	�g�Z�X���%C˄/�� lc Z"��V��y���R�5�Hp����bұ�('�Y_�5��^�a��r��KY�ΕGS�Vx�"BY�>��\�K�_���ǀ�{_��[α`ذ�(�=�o ��^$,�e8t(i���b�^�6� yY@pd�Cz� 
cܜ�/�+4GV�bdkլ��}<wI;ʹ_n�R�Iy:h������^���05�b��3b~ z�o#mI<����f��˘���'!~W�sK$#�n
/7�	6�5/��!�ǎ_��
��l��w~YeX��6}�yX�!B�}�}A�4B�@J�ƔRg��O�c�rSm5pk��C�y�<�`}tjv���\v���U�k��ah�ѓR���f*�Iy>��6���C�Z���̴6��������:��~�TV觌�œ4��?O/�ыl�#Cĸ�p�v��,�qc��W^4ş��*N�Vy����	��2{p|R��ņC\�R� Ed�B/�X���%����FF�u��S� �Z�J�B��OB۔�W�K�%�"�Q�B;׭�K_IuX?U�U<*�#�d@��6=ٖT��v�J \[����✯9>����l��܃A���bh��F�՝��RH��ẑ�U�"6�噆B���������ez�      W   �  x�]R�n�0=��"_�b;�=G�"��V�@�L���*WI���c����1��"�rxo潙������2И��L��2����0�-�S"0ZXSY�?����J��l���C�	�agT�C�'b3��3W�C!~����T��o��ٞ�Oi� �vܭl2��������.dxLG��*��E�iz�`e�c�Jkx�����Z��C�o�6��D��Vnu������y�3�L���}���N��w	J����ZX��t��S��6�L����L�4x��9�y':��wJ��4������W%~��e<���Ɏ�Wʴ�N48��"o4\�x��yQ���v�x���J���u��z�L�V΢�����I⦃M�eIKs�׼���B��a�&3A�l��b��gFe���D����T���>RS�� ��?�� ܌t�;&@�G��V�n�L�\~�٠(Y_�@kE����)�q`��Qƿ{�������      X   U  x�E�K�$1C��]f����]���#䬈�HI��UBl��3��=&�R[i�߽t��,�Qr�Q���,ʷ�K������(c�mL��d⩉^����kHu��g�� �rHȬK�V�I��O:��� �Ư�N�K0;1��35���L9�f=�^b�2��`���e4 r2�5 rN���8��^ �3i �ONj�x|Cē�J�wFs�ꓙ��OL���'2��U 	�.�2��ΓA"�ݖ��~Ze�$�(c4I,a��~��3���ɑC65��������E�ubd�pd6�#�7��m'Eޛ;)rsN�9�X�����<��ˤ      Y      x������ � �      Z      x�U�[���nD�uc���\<��ʶw-���Q��I�`0[��������￟�����v���w{����}��������Um���uo���>���[�V�o�s+�۵��[�����l�[]�[��T��wG�m�[cj�oUٷ�V�l��]�-�����[Y�-�����[Y�-�����[Y�-���v����v�=��}�Q��[�qn�o-ǵ���v��r<��[��n�o-Ƿ����v��r�v����v�Vv��[��/�����Z�{;�֟����|������Z�}�~k�j�~k��]��\�v��r���[��[����ޮ�Z�g������}��o�����n��l���ݮ�=��v��r���[�}m�o-w��Z�g�k����g~��[ٳo�oeOm�oeO�緲�ܞ߷?���T_��[�so�o-O��Z�o{�����V����[�[��[˛����=��������Z�{{��^�++�l�o-oY�}�~�����ۿ��������������ܾ�ʾk�~�����[��l�o-߻}ZK�@�@�����fp/]�q�e��6��,��&p?u�fo�������|{�]VroS���m�v�#=�4fZ���c�m�1���i[i̴�4�ږs\^O�w��^�lrc��k�]���6�d���t�RW�钭���%k]m�K���Z�,v�ݭ�������%+^m�Kv���ז�d��mw�~W��ͮ��%�^m����z=���V�dɫ�xɖ׉����e/Y�j�^�=r�O6�ڢ��z�M/��j�^���v�d۫-{ɺW[�E���%{_m�K6���|]����|��W�������%�]m�Kֿ������/y�j�_��V�d�}@�T����b�1Z_�������%Pm�K>����@��/Y�j�P�Ֆ�d���B�7T���?���g����%?P�!J^�ں�,|�'(y�j�Q��~��;�}E�_T{��W��%�Q�#J~����A��/Y��m���d��a�7٫�@��>����4�����8"��:�}G��C��h�s��
	���,:OG��C���zh�7 Q��{��~;z��/G�C���w}�}���������}�/:�ζͧ����z�~϶����	�4�l[p^�n���~�Y;u��^����0T8�z{6�����\�7W����5T�j�ڶ�}ݟo�g�����l\:W?�K��z�B���[��7���w��[��n_w���m�o��m�-�z����F�mknٛ��zk�w�[X�n4v�=�5�m�*���z俞��i4۠X��i��Ⱦ?��=��l��(���oL����^ᱷ��[F�~����;o��������_���}�+��^~���~����� ���}/���]�Y��8�5�m����|�W>헯��'���������"����X��|�_��O��k[���|��?�w �g|�ۍ�v �~L�5*ځ!�qȎ����w\�n_���@��y�g �@��̷@�@Q�ܲ��@&l��������=^�i ��"���g��i�9Ʀ��hWX�����FL�ǲ��@�QN�91�	�#FZ��"���c=��5��
w\�ɍ���@�0�8~o�(}K���h� ƃ8߲n��O����7�ς����O�T���<��O���O;α�!�BS��E�]��,`odO�v9V��.Ggwq�..���szQ/cTf�k��l܈�,{��m�}g�z����M�u;��	�nG`7k����\A��|�܎C�H�H(~,N��q����=�~k~�懐�qL�,{�� �۶<@ }B��k��mym[^�3/+|3b�~�/a���%0|��6�c���>�'��I��u�w�G�9ekxg`4d3�7�W�%��w����n�v���+fK�~��S�^�f�a���3��re��A�CG?���u� �G{��r�1�������=qh_��a����){6:�����0�I��y�޻����x�4n�{�celi�~6�������޺Vjعa�����_/Űw��[���x�VLs�n����on�8w�ۭ��I1;����W�R���Wn헻w��]��{dǞޫ����{���y����=g��r8O�G��i+�������D��z������l�Ӿ��x> o�>6F>�W'�a��6�x�:ދı1t�����v��k��ە�$��Ԥ����go������K|�_�O��Iie�۞����\9ů��i�_��O~����||$����U�3j��=�N�pw�p��Fw;ɹ�ٹ����x���yǏ��#��O��иQ�m�m��R�#w�
G�q��F�o% Gp��F�m%�Fl��Fk9��%��T�1*�2Ɩ���O>�E|Y)둳QĈ"���g�w�\R�/5��'��y��רu_	lg�)A�Ax��^���I�r&�/������c�c��G���V�c~��U9K��j���Y�t2���;�i�=W_p�u'���s�ԝS�x���U+�����\~>���{�@J��ҵ��~����8��3�/��,���]�J|��7�ӵ���|�-߫
ﻸ)��x���T�+�>��+M>��D=�r}BA�ޫ8����>����[	�1'�����>�N��S�P�y\��e��f[�����yl���z���e�p*g�RI]�#�T�45��:x��|w��r��z���}ϑqi;n}y;�����y�v�?�<~B,������~;_��������S9U߹�����2�'̖� �e�^���� %��/h�"��;���a[������<��64�~?yᖌJ�
M��"Ԗ�����#�+��(B��4��騤�P"� "���'�O��{-�փu��?��z�Xv[��,������E��=�!ou�}8d#����(��O9�s��⨣�Y����)[zWT9��<���+Cx�E=eU�ʊ9+������O����%x�	�t�.�-f�@J1+���V��;JS�n�u�����n���:�Y&g����������B��i�QKG5�@\̕�~}���~�J�R��pn�ik���=1>���O\)�6�=�ն�O��Gg;m[M��Y�!Έ<�h̢�{{tO�ˣ�yw(1�t� O���y�~�ܶ�o��W�m;��YOG9���v�*��~ۆ�m���QM��6}�^�����k~L��O���{�t?_��O��k��	�b�mÿ��~֟��ug���2�/���~s_����;����ݸk���0;����!��f��Ǣ���"����G��G��v�v(�98��W���8p'�;��[ޝ[�����?N��:��'����W�#&2����hI����:����3�;��%�]��!���A�(��H�UP �2�/r���x�8�80|{����ʹ��X�CQSpn7[��}A$h���-���U�����Q��;��EH:F�_�"���(\o����27��'Vh�J�\��`����)��9 urrO�ܓ�{�/��4��y�=x�"/����E~�'�u��N���wJ2��Q�H��1�`#��/��,}�H��|�9_��4HPp.sp.��5��}ѐ1�{o�ޛ�������6����ݶ~$&���>k��?�s��T'oW'o����qS���xo��;�5�T�-�g�ѐ�������z��z�C��8�|��=�=Ԓ�{���r4�p���_�����z����⒣i���w|�_��k�9��(�|��/�'��A��ﺽv�E�uh�:g��ӑF���X��<�kI���4�_r�)mbV?��Y�kr���Sw�����s�B�J�����=չ�� ��|v������l����2�g��S���!����~����-uQ�F��8�s�g_��>����;��n#��\V��`+p�������[�K��UOl�������Y#����ݨ��I4������'5N�9��䷼9�V��sk�`-l1�>�N�sAq�5Tys����{�1�����v��*�}�6��O�`��-�+�I]ӵͯ��'����    ����>{����6����~��_c�Ox䃼n�:�uۦ}����&�����_w3_w��n?�c�w��S��G07
����"5V�5^�"6f�
��"�6j�Y˞�@�etKi�\߭�"�ϑ���TYD��$_�qGѲ%�Ф��b/�E�.B�0�b>�6�q6X��|LhَF�lIZ�7>8�|0��}���?��)�k�E��\%�0�q�AV�pV�]�����{RJ.ד�>����9/~�3���\ҾXd��v�.o�pS���N�i�pr����P9;T�N����� E�7��e�iA=-�O��y�	��yj���,Z�@��|v.N�5�|W�w��]�Mˌ�"�T�,�2K�/�W, �������j=0�3���c,�!<��cD�9?���Es<wV�x�q��8����~>���/i�����7�|9ݯO7��r͸(���}A&�;"f��Yg��YƱ��K}d>e�/��Y�;�q7f�IG��GS(����II���	ysY��*bڏ���f�s��&�	M*q�Jh#�{IB�G��Z-�~��\wX����"��jqH�gd���n���$t��=�9�@=���U�}�]���������	i�8���V�@��QtH�9�@��C����_����5[���^�V�b�ZY��������%(k�ԌS��f��mud�����u�m����X��#�s4�<�5���~t$}(�>h�uWo{���u�.�c��{Y2)Φ}6���m�){r��<u2�~v����'���>���g��S{�e�u�};���V���k�KY{jޮ{_g^�5�~6����ދ��s,�(�)�ڮlS�v���k�w{�[�>h�u�n_+#������z�T�]9~z/?��x#{$|��~Ǿ����4?m{���^|����\Uz/��66x�ޣce�~���������"������u|e!_��K�c'�oe��Fw��j�}�w_�͟bg��}�מ�����~�������8~˾��g��y~��z=�}ב�f7���ػ=����;:� 5�(c�W+�`F�]�;�q7r�)�fA����ӻ�vG�.k}���tt�������Gw�j��~��ot��v���W���7B)�2:k���;zy���Mu��B⩜}갈�����|q�w��8̯�`[f�mu�޺�|]�ai�r�/���4NP�iT9�̐��@Ta�OS\�3�h�+����l�;�Y����'�]��>�Q���N�\�o�/�W�ʾ�.��U�#�!q��{(����[f��E6�r6�bg^ޙo��[�\^��w��i��c�C��#
�n��[���9��i��9WPx�<޾ c�gM���-J��w_�xo<YM�#���p����5?^�s�f��V�wF��|G֚(�O���rW[Q�.W����㰗w�����j�ݽDK�+��V��8^-ƣ�xQm|iy+��N��y��v}C9�'������{�9��!�@`׭h�+w��]	�c4ѕ;�:(c=��?��o�o�0�3�7�5:��=�:���aw�����	Y�{��K?�
:���y(l���@��}��IŌ��	��"��/�G{�v���̆h\�Fc�'�0�Q�/3�����МG�{�dGc�C8�h�|�*��k��_Upb.�]�G���skd՜Y;�
���TZ]m={O���g��S����}ꄟmYNY���Ğ��X����L��Uڳ����}ވ����8���W��Kg��2w�]�7/�Ϋ����M��u��!+!5d��^���uw��� ]�t�>���)����jku�-�#Cd�W�!:��}]��ۣ��w�*rx����]Wx�	n�wc�۪H}^o�Y��=��g��y{:&~S�u��g��yS�u��*�+�Td]��͝hTc]�}ۖ��gt��+���px&{'��}^ɞ	.������i#��k��	~���qѻ}£pd͓���}:�����Gy��c�Oq>\Y�e��?_����������}�I~�%���%\4�����1�e7eS���k���v�3��T�wW�����Y�*JE��%n2�MV��{���y�z^Yzr�$��Y�"eU�[I�r��b s�C^>�˓�*篊�T9CU�
����Ue�1PG1��H��3���8F$�U�fձ䍆�Q�y�QC2�<�%j�Jo��$�U�ld�2��)��t�D�
b"eE����1~B��}x.Y��k����rU��U.g��YѦX�U,�V�su�D�ǘ��[9�V'���;Ź�=\_�����^��W/N��Sya\�0.N��r-�EGE{��� iW���'e퓺x������2��F�r�eq����'u��h�6Z�k	3����eCJ(3:����x񒲂IA5(�:@#�2��=~b{��C���]R4Y�;-���^I['"0?�gI:M'���D�2�^"�ב7d�2#���9�E���/�m	2��	��a����`vr_�ɶ~/Y��Y�4˝�a��Z.�Nʊ'�Bg�>��>~BL槁�q�i'qM��ҩk�7��t|1�C)ݸrCqǵ�{3[ �y !Lr��Oʾ�k]�EX����:�(\X��o�ݷ��/νq�j���E<Tu�����:���y�)a]	���`�Ir6���w�b�l��~W��Vϖ�g��5�EÖٞ�w�޻�h��J��������~u��}�������]^��T�V�й��n�z˺��ݷ���pk?Pw-[d{���>1o���w��Ir>��`]la����=ϽV�Qs���������=f��,��v���m�
˽K����Fu��]g�<�zo|����B|�?�Dr<��|�>��#�!�u,�)�%'����������}:oߋ��UE���%:�A�N��N��Vw�V)ї������V�nV�K`7K`��vF]��2'��~���Ĳ�,�Ρ߹<�����KTs�j.Y̡���)�2咦ڔKLr�I.yǡ����X�K�p�.¡CHk_���/�o��`�^��'w�Z�C���a�@��*g�
zn���ϓﲗ<@���#��E:` �+�û�X��CӔ�lW�)~�O���r`��W���>g��x��c-徿"-U�M5���1TNɭ:U�����;�+C.3���w��]$�ʙ�"�T�5��h�Z��C����r�z�K�Qo�'t�'D���'*Z�}���cy������ƿr�_�K�t(�.�ҡU��q`!�W�`��K�t�@���������W�����XS�[&�T�2R�e����^��׳$V���M��K�tTr��Z��p��u"������-�7K0ը{���Ԛ^ך�,�6��w��p�eY�W���wT��\`�'ι�"qU�^�����q�e��O�sFԤ�lR���y�B褬v��@���%�:T^�7��0�r(�&Jh����_���O(�'J�u~����^��kZ�ݹ�� O8;�Pnn�����N��f��gU<j㮏Sw-����� ��= �g�?����gp���9l�0~����3w���am�뮰��a�j����6���3���+r�OaoA�y����y;v����&��\��k=�޳����Oߙ{Ϩ���N��4���w5�����,�.��YS�:;v�(q���	�B�Dp���'�/��P���w���׳���V��e�3�;�b퐛�
c�\���N���vk}dv��y:.{�=}�G�<��Pew�d?���c8uݱ��?=j�S��l6�Ð�1��ףXV���0��B~{���}�֨��-���͚!d�«س�/�1��?��V��������^����d���p��g��y��~��_�O��k��ݎ����`�א�1�a�Us�u�q��؍7pe��DR��H���E
ِ�vH_�]������[�/����1�A��[p��$�		k$��	�D쇊���:�K(~(�/���ݾ��f��e����0&:��]�/�eVp�:+��*����"�~�hJ,w&'e����[f��    ���"�0O�(ݗ��}A�4�F�wsw��{���!
U �Փ���A�*�����VI!i^�5��R�p!e?R��U����,���Z#ƌ��!�/�W��+���N!�^�F/�"˝�E������r%�/�A�[�5taL]����a�w/4�2��+)k�R�e=��3&WQ[qn�g,+4v`��6�
@Lm��B����X4=�;�x�^�����]ӳl_,+0��r>� ������%.D�J�m�/�"f^V4/�z��^�kh��RZc �-g�z%E��\s/��e�q�,����s���e��B����X�����B���RȠ����U�\��cY�G�ohMA�r偆wvТafS����R���63j������e�RWV��3b52J�*��g�?�+�_A�������(�Y���Z��;z��+䏜CBG�Z��RX�⬎�{@���T�]�>��.�	G��t!�����t�Ð�B��}N�*ɮ&�m!OYI2V�Z�9h�A�*�YA��5ۋQi���k��6�V��g�}�W���o�iV.U\Wr�̶��f[;�	+O��m���rk=h�Y��̒�K䕜[�Gk.-Y�d�ź_֜Y���MG��р�5Y�e�FƯ�1�}��#��\�����~�o�^OC����޻���rn��_��O>�k[��^�-�A�f���q���+�=O����r��k+���5"m�H[C��T3p���j��F&;������j��j�N�u!�ƘضF��mC���5�l�=�G�Ick�ט���a�iXk֘��T�	Uk�јqD�\�.�+c���6&��{�"�T�4���U���uE;]���pe�Q��6���x�:'�G���L^�"*�#*L}��zMu�bk�����p )��F�l�����`_����5 mLH#�lnk�<*g�
^��E1�\/RHu�����E	�\�.$˺�Eꧮ1�maS��ص1wmV���*��r��Q/k�B'u�
�e�k�v"s�iT�kTH���k��Z����O
ٓ��I1�<��T��T������X�1�o���f]�B䤬t�kܛk(�Lo�L�v/���S���rb!�RVE)RP�<T�hXϘ.�ƿ��o�ۭ�R�C*�D*d�ڇ}A,`�I���*�^�c�/\��\>Z�����{Yݽ�R)���ӊtR9�T$��Y�B���HX���/+Yٛշė�W��h�Ư�w' H���F�\��N�g{�@����A0��޿)7蜆�ø�0 �*�ԩ]�F�ܪ�Uݝ�H�ZY�#+��C�GP.�zyh5w�9��Y��)����̓ܮ� �nW������D��Z|h�Yw�|�s>�)�*�����~5��]t���}�K�E�G���K�^BG����9O����L�9kD��;��
��@d���/j�(:%�*���]}W��Kg����F�ɰ���#j�(|PsB���?���|��=jzV�C�:x�D������eYF8�换sg���}��!�6g����h�Y�o�O��Ur�˭aN?�{�˳fZ��3�7���䖜_B�ܺ�h�Y�Y���}_��r��z�{�˭_�U�e'�<�~<�>�9�_��O����4_�����KΝrԙ]k���?>#�m���A��'���,�ZÝa�4����_�x�ݞٔ�vJ����8���r�\!.^Ca|�м���C�������5�y�h��)�kL򘓼�I�k��-����i�k��⎉�kD�Q���������*w�ɭ�5���7����.��
'T�DE`���Z��Z����)ȹ�1/6�}P!,RV)F��1�O�S�)X������R�.������b�Sy�S�D�cDi<�cp��5n��a�Y���#)k�b�e��b�Sy�S�LX�(,��ˊ�Eګ��*���Z{QH/W�iƲ>c1,�<1�pMe�T8��G*FF��F��2+��Z��Z4��;��dX9#V�9��qR�RE3_�����9�{Y�(��k��{Y罐r,�9D�2۸h�+��սY�I�����p�\\��~�(����E�`�w�h,w��r��5�zL��?C1�L�3�f��={�<U�>UH7����R���
�ݺ(9��P.ڋ�=���a�c���=�es���)e����aA].󗋁S�S�{,��Bd��4YH���V
����JQJ/������J�ZX�/,+�}��(϶-Қ��f!0_V�/R���dA�.s�A��F��sg2v��]Hh�u4�[� Ǔ_m#�od��Zm�@���N}h��{%C�2�_��[�������!u�/à���ܮQAh���'D�qBHx�F��F��j�]�Kj��^��ft�P�2< �]y�X#4H���5a|n<C7�I�\i���$혩�?3�=�Q,sq�����>���K"`h�Ҙkc���?�P���X�&�Es& :]̩R{p�1����$b����lh�!m;q�N�������s������-浅�2�*C�*�V�&���>��؟�Y�@"��Re�@�<�<�3��6�{0-�%'�O�q˾2���t u��1� �q\`�C)?��d]����8J�q=?��Ċ-�pW�C�M�q�Y��B)�%���=P|3y�xsW�
���q18�<=�hf/w���2����d�ݷ^4��7���p/{�5��֏�.�� �x�Gh���f��W����b=���Ą��1	j������RȱrrO:Rȱr��H*�g��/��d`�F6pQ��y5H���wʿ��Ͱ^iÑ7\�)\�vǼ�%�8TW�o���@�Z�p�xBa�%>9�'��u` ��␦�su�<3�CKx��=q�'n��M����CJ-Ϋ�&Ƹ�1P}c�o(��5��J��i�(WfB{bܣD�c%� �kcɫX�*���\UL�UC>��p#�P��+�$�g|m��[�R|��)��2*4AǝСu1�_%��ΐw��GN�4�T,�1�&�٨Ő���%{0��kT�?�dߘ���T�������:OO�)�>������@j���a�Q<�(#�'��C�������XA�#�@_�Fj*7a�F�������V�||�!RQq>*4��A>>֐oS�_�;к�ѿ�Ĥ�&�?�=,i�8הE�̬U�U�%_;�kWs���X���c�6Vy�������i�X>@�*H���u�BQ$���X��Q�ɻZdc-�0 (�Z�rN�?�����1�<z���L1�)�Jcni(%�x�=�|K(����k��@_X�g�q<�2�N0�>�c�cHd葽�Vg�@�U�eH�1�>���Js����C$��������TqƎ��%����!��C�;�u��i�Դ k�F�۸/�-�j�Z����>P.��=��t�p��������sԁ��݃�i�yh�1�=���
uYtC���D"|ޗ,�O���׫T:j�K,b�E,�`q�X/��HX�Y�6+��q��3f�,�졐�����>�	�g������,�
��L���ı��F�$��ls���\� #kɅ$r�I�Ȝ#f�[y:$vsM�{�p8�{�N�O�	���
�qu1H5�z����<C����1�;�c�},O��8��b���ʌ��'��	��8_�bU� ��s�]á�t�5j̇b���YB:/��d��#�G�6nY��)�4�J�a�c<�1�!Ċa<c<�1���}<aXN<1�/�?��}�{"��(��X�,��Ľ>A�9V|�α�s(��5���<��ы��� }��X� �ŪiA� �?tĘ��c����1��;�䝬q c �б*t�x�1�l��5�%�3�sad0F�}0كi�C�dw����q]/kd���z�ر}XH�s�����
��.sFBI/����X9:P�c>zm�7�9�T�EǱmA�?V�#��eA�+� ˵�N�Aʈ�A�9Va亘a���߃�M�p�h�N� �	�XG2g��Y���Ղd�(g1�,�Ǌ�A2ֈ� P  �{����@��7l+�\����<�w�6��ي'mjq�/���{��[m����Ia�j<�54���~}�����({�3��/���D8'���%�;�xנ�1�|��;�����֬��c*!���X3Vk�H�q%�^	"Z��Vh����C�`�5�PbM��B�bs�n�Ns�I� k��\Q�D���7H�H�C�����w���� �밇y��=�w���q<���D
n���q�w �Ƭ��k����mh���?�x�xh��;�C_���T1�*�'�i�X_$4���#a�x<g���m̠!�xF-���]$a�T<I*��牆���w$4��xa$x<<ȫ���ݖ�܈4��7H�8��&��$�`�:lhv�7Phpy-2��3��QĽm��u#N��x�s�$��_"C�oIoL�%�a|��F�B4�-I��ɱ��D!vȨ3~k�1 �Һ�a\_�ɼ�F�����7z���Vi�q�EdO��l����<��O�"���kh��{��x�7F[�*'Ǣ;���=yʹQ���^�⡬��
h�U��4`���n�@��y2a�i<�4���
�A4)VN
�O����M �����Z�⾵Єw���X%;�ŚC��31�>�ݷ� �x����w�&��P�Y��S��x�^"K�fi0�3��)p��d��bM�:K��(�`M������UqU~ǹ��VR��?������Ԉj��o,�Щ�y�g N<'K�g��,*��ү��c"��~�j�}���wt�.��`�/������9��7{�h�OprA�fP�G�1�:�	Ò�����h�}̼RB��P�OGm\q/W�5�ڟ��h�9d�b-�@a�y�aY<�,H���6af<3��b�^/ϘɽFP���k��8�D扇�cyF�	�dA|&V�	�h�.Z@�UЂ�Y�pbU� ��z�A��� �w�����/?P�b�Wuϻ�<qOOhS�{UC�O���sq�.4{���%��Hzt̑�")��X�20���1��-�����i�,�\�0���<�9~_��Ċ,m���Y�w�5<~L�_�?��'��\��H�1S��Ø�k�~��d��h�x�b�
����d�.��1G:����8�0����X�;�H�^���w�V����	Kk��K�yd���a��.O4	�ű�q����re�I�D��^��θ�34���5��?��o�J��g������0�*�z�s���%N��|/A	?ĸr��Y�\#"��i0&+��`�.� �k�Y�X[%��*��%�м {����w���X�d�@���A�8�=)�JJ�֊��B�9C��Si-�@�ټ��1�zb#��Hho�{CX�	֛�=�{gA<��7%���A�X�.�j�=~�eO�"��������8�x�g���Bkp�F��s����=�!���'�k˅� �|��V�V���'�u�V��Ua�g<��7{u�8�%��F{��=�tD��c�� Wit�h�x�M���;�ԜJ���]M���rIKmIN��S�TN���K�3��������/g���      [      x������ � �      \      x������ � �     